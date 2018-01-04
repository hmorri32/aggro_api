class SpitCastService
  def initialize(spitcast_id = 229)
    @client      = configure_faraday
    @spitcast_id = spitcast_id
  end

  def configure_faraday
    Faraday.new("http://www.spitcast.com/api/") {|f| f.adapter Faraday.default_adapter}
  end

  def weekly_forecast
    get_json("spot/forecast/#{spitcast_id}/?dcat=week")
  end

  def daily_forecast
    get_json("spot/forecast/#{spitcast_id}/")
  end

  def self.daily_san_diego_tides
    symbolize_names Faraday.get "http://www.spitcast.com/api/county/tide/san-diego/"
  end

  def self.weekly_san_diego_tides
    symbolize_names Faraday.get "http://www.spitcast.com/api/county/tide/san-diego/?dcat=week"
  end

  private
    attr_reader :client, :spitcast_id

    def get_json(url)
      JSON.parse(client.get(url).body, symbolize_names: true)
    end

    def self.symbolize_names(response)
      JSON.parse(response.body, symbolize_names: true)
    end
end