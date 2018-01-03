class SpitCastService
  def initialize(spitcast_id = 229)
    @client      = configure_faraday
    @spitcast_id = spitcast_id
  end

  def configure_faraday
    Faraday.new("http://www.spitcast.com/api/") do |f|
      f.adapter Faraday.default_adapter
    end
  end

  def weekly_forecast
    get_json("spot/forecast/#{spitcast_id}/?dcat=week")
  end

  def daily_forecast
    get_json("spot/forecast/#{spitcast_id}/")
  end

  def daily_san_diego_tides
    get_json("county/tide/san-diego/")
  end

  def weekly_san_diego_tides
    get_json("county/tide/san-diego/?dcat=week")
  end

  private

  attr_reader :client, :spitcast_id

  def get_json(url)
    response = client.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
end