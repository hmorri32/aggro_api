class SpitCastService
  def initialize(spitcast_id = 229)
    @client      = configure_faraday
    @spitcast_id = spitcast_id
  end

  def configure_faraday
    Faraday.new("http://www.spitcast.com/api/") {|f| f.adapter Faraday.default_adapter}
  end

  def weekly_forecast
    parse_response(get_json("spot/forecast/#{spitcast_id}/?dcat=week"))
  end

  def daily_forecast
    parse_response(get_json("spot/forecast/#{spitcast_id}/"))
  end

  def self.daily_san_diego_tides
    symbolize_names Faraday.get "http://www.spitcast.com/api/county/tide/san-diego/"
  end

  def self.weekly_san_diego_tides
    symbolize_names Faraday.get "http://www.spitcast.com/api/county/tide/san-diego/?dcat=week"
  end

  private
    attr_reader :client, :spitcast_id

    def parse_response(json)
      json.map { |forecast| forecast[:shape_full] = delegate_shape_score(forecast); forecast }
    end

    def delegate_shape_score(forecast)
      case forecast[:shape_full]
        when 'Poor'      then 1
        when 'Poor-Fair' then 2
        when 'Fair'      then 3
        when 'Fair-Good' then 4
        when 'Good'      then 5
        else 0
      end
    end

    def get_json(url)
      JSON.parse(client.get(url).body, symbolize_names: true)
    end

    def self.symbolize_names(response)
      JSON.parse(response.body, symbolize_names: true)
    end
end