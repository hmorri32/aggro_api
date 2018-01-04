class Api::V1::Spitcast::ForecastController < Api::V1::BaseController
  before_action :set_spot,       only: [:daily_forecast, :weekly_forecast]
  before_action :create_service, only: [:daily_forecast, :weekly_forecast]

  def daily_forecast
    json_response(@service.daily_forecast)
  end

  def weekly_forecast
    json_response(@service.weekly_forecast)
  end

  def daily_sd_tides
    json_response(SpitCastService.daily_san_diego_tides)
  end

  def weekly_sd_tides
    json_response(SpitCastService.weekly_san_diego_tides)
  end

  private
    def set_spot
      @spot = Spot.find_by(spitcast_id: params[:spitcast_id])
    end

    def create_service
      @service = @spot ? SpitCastService.new(@spot.spitcast_id) : (json_response({error: "route not found"}, :not_found))
    end
end