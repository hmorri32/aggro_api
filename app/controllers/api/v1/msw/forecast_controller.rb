class Api::V1::Msw::ForecastController < Api::V1::BaseController
  before_action :set_spot,       only: [:weekly_forecast]
  before_action :create_service, only: [:weekly_forecast]

  def weekly_forecast
    json_response @service.five_day_forecast
  end

  private

  def set_spot
    @spot = Spot.find_by(msw_id: params[:msw_id])
  end

  def create_service
    @service ||= @spot ? MswService.new(@spot.msw_id) : (json_response({error: "route not found"}, :not_found))
  end
end