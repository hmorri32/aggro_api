class SurflineService
  attr_reader :client, :surfline_id

  def initialize(surfline_id = 4245)
    @client = configure_faraday
    @surfline_id = surfline_id
  end

  def configure_faraday
    Faraday.new("http://api.surfline.com/v1/") {|f| f.adapter Faraday.default_adapter}
  end

  def weekly_forecast(get_all_spots=false)
    get_json("forecasts/#{surfline_id}?resources=surf,wind,sort&days=7&getAllSpots=#{get_all_spots}&units=e&interpolate=true&showOptimal=true&usenearshore=true")
  end

  def daily_forecast(get_all_spots=false)
    get_json("forecasts/#{surfline_id}?resources=surf,wind,sort&days=1&getAllSpots=#{get_all_spots}&units=e&interpolate=true&showOptimal=true&usenearshore=true")
  end

  def get_json(url)
    JSON.parse(client.get(url).body, symbolize_names: true)
  end

  def build_surf_attributes(response, zone, forecasts, spot_id)
    response[:Surf][:dateStamp].each_with_index do |day, index|
      day.each_with_index do |timestamp, timestamp_index|
        tstamp = zone.parse(timestamp)
        forecasts[spot_id][tstamp] ||= {}
        forecasts[spot_id][tstamp][:min_height] = response[:Surf][:surf_min][index][timestamp_index]
        forecasts[spot_id][tstamp][:max_height] = response[:Surf][:surf_max][index][timestamp_index]
      end
    end
  end

  def build_sort_attributes(response, zone, forecasts, spot_id)
    response[:Sort][:dateStamp].each_with_index do |day, day_index|
      day.each_with_index do |timestamp, timestamp_index|
        tstamp = zone.parse(timestamp)
        forecasts[spot_id][tstamp] ||= {}
        max_swell_rating = 0
        (1..6).each do |index|
          max_swell_rating = [max_swell_rating, response[:Sort][:"optimal#{index}"][day_index][timestamp_index].to_d].max
        end
        forecasts[spot_id][tstamp][:swell_rating] = max_swell_rating
      end
    end
  end

  def build_wind_attributes(response, zone, forecasts, spot_id)
    response[:Wind][:dateStamp].each_with_index do |day, index|
      day.each_with_index do |timestamp, timestamp_index|
        tstamp = zone.parse(timestamp)
        forecasts[spot_id][tstamp] ||= {}
        forecasts[spot_id][tstamp][:optimal_wind] = response[:Wind][:optimalWind][index][timestamp_index]
      end
    end
  end

  def build_swell_ratings(forecasts)
    forecasts.each_key do |id|
      data = forecasts[id]
      data.keys[1..-2].each_with_index do |time, index|
        next if data[:swell_rating].present?
        prev_stamp  = data.keys[index]
        next_stamp  = data.keys[index + 2]
        prev_rating = data[prev_stamp][:swell_rating]
        next_rating = data[next_stamp][:swell_rating]
        forecasts[id][time][:swell_rating] = (prev_rating + next_rating) / 2 if prev_rating && next_rating
      end
    end
    forecasts
  end

  def parsed_response(days)
    responses = days == 1 ? daily_forecast : weekly_forecast
    responses = [responses]
    forecasts = {}
    zone      = ActiveSupport::TimeZone.new("Pacific Time (US & Canada)")

    responses.each do |response|
      spot_id = response[:id]
      forecasts[spot_id] ||= {}
      build_surf_attributes(response, zone, forecasts, spot_id)
      build_sort_attributes(response, zone, forecasts, spot_id)
      build_wind_attributes(response, zone, forecasts, spot_id)
    end
    build_swell_ratings(forecasts)
  end
end


# http://api.surfline.com/v1/forecasts/4789

# http://api.surfline.com/v1/forecasts/#{spot.surfline_id}?resources=surf,wind,sort&days=#{num_days}&getAllSpots=#{get_all_spots}&units=e&interpolate=true&showOptimal=true&usenearshore=#{use_nearshore}

# http://api.surfline.com/v1/forecasts/4245?resources=surf,wind,sort&days=7&getAllSpots=true&units=e&interpolate=true&showOptimal=true&usenearshore=true

# http://api.surfline.com/v1/forecasts/4245?resources=surf,wind,sort&days=7&getAllSpots=false&units=e&interpolate=true&showOptimal=true&usenearshore=true
