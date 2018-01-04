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

  def parsed_response
    responses = get_json("forecasts/#{surfline_id}?resources=surf,wind,sort&days=1&getAllSpots=false&units=e&interpolate=true&showOptimal=true&usenearshore=true")

    responses = [responses]
    forecasts = {}

    responses.each do |response|
      spot_id = response[:id]
      forecasts[spot_id] ||= {}
      response[:Surf][:dateStamp].each_with_index do |day, day_index|
        require 'pry'; binding.pry

      end
    end

  end
end



# http://api.surfline.com/v1/forecasts/4789

# http://api.surfline.com/v1/forecasts/#{spot.surfline_id}?resources=surf,wind,sort&days=#{num_days}&getAllSpots=#{get_all_spots}&units=e&interpolate=true&showOptimal=true&usenearshore=#{use_nearshore}

# http://api.surfline.com/v1/forecasts/4245?resources=surf,wind,sort&days=7&getAllSpots=true&units=e&interpolate=true&showOptimal=true&usenearshore=true

# http://api.surfline.com/v1/forecasts/4245?resources=surf,wind,sort&days=7&getAllSpots=false&units=e&interpolate=true&showOptimal=true&usenearshore=true



