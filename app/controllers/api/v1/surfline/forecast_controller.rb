class Api::V1::Surfline::ForecastController < Api::V1::BaseController
  before_action :set_spot,       only: [:weekly_forecast, :daily_forecast, :parsed]
  before_action :create_service, only: [:weekly_forecast, :daily_forecast, :parsed]

  def weekly_forecast
    json_response @service.weekly_forecast
  end

  def daily_forecast
    json_response @service.daily_forecast
  end

  def parsed
    json_response @service.parsed_response
  end

  private
    def set_spot
      @spot = Spot.find_by(surfline_id: params["surfline_id"])
    end

    def create_service
      @service ||= @spot ? SurflineService.new(@spot.surfline_id) : (json_response({error: "route not found"}, :not_found))
    end
end