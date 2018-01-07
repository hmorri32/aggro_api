class MswService
  def initialize(msw_id = 4562)
    @client = configure_faraday
    @msw_id = msw_id
  end

  def configure_faraday
    Faraday.new("http://magicseaweed.com/api/#{ENV['MSW_KEY']}/") {|f| f.adapter Faraday.default_adapter}
  end

  def five_day_forecast
    parse_response(get_json("forecast/?spot_id=#{msw_id}&units=us&fields=timestamp,localTimestamp,solidRating,fadedRating,swell.absMinBreakingHeight,swell.absMaxBreakingHeight,swell.absHeight,charts.swell"))
  end

  private
    attr_reader :client, :msw_id

    def parse_response(json)
      json.map do |forecast|
        forecast[:timestamp]      = Time.at(forecast[:timestamp]).utc.iso8601
        forecast[:localTimestamp] = Time.at(forecast[:localTimestamp]).utc.iso8601
        forecast
      end
    end

    def format_timestamps(timestamp)
      Time.zone.at(timestamp)
    end


    def get_json(url)
      JSON.parse(client.get(url).body, symbolize_names: true)
    end
end