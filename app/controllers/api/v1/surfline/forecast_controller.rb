class Api::V1::Surfline::ForecastController < Api::V1::BaseController
  before_action :set_spot,       only: [:weekly_forecast, :daily_forecast, :daily_parsed, :weekly_parsed, :tides]
  before_action :create_service, only: [:weekly_forecast, :daily_forecast, :daily_parsed, :weekly_parsed, :tides]

  def weekly_forecast
    json_response @service.weekly_forecast
  end

  def daily_forecast
    json_response @service.daily_forecast
  end

  def daily_parsed
    json_response @service.parsed_response(1)
  end

  def weekly_parsed
    json_response @service.parsed_response(7)
  end

  def tides
    json_response @service.tides
  end

  private
    def set_spot
      @spot = Spot.find_by(surfline_id: params["surfline_id"])
    end

    def create_service
      @service ||= @spot ? SurflineService.new(@spot.surfline_id) : (json_response({error: "route not found"}, :not_found))
    end
end