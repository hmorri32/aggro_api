class Api::V1::SpotsController < Api::V1::BaseController
  before_action :authenticate_request!, only: [:index]
  # before_action :set_spot,              only: [:spots_with_forecast]
  # before_action :create_service,        only: [:spots_with_forecast]

  def index
    json_response(Spot.all)
  end

  def spots_with_forecast
    # json = Rails.cache.fetch("#{cache_key}/forecast",) do
    #   render_to_string json: event.viewers, each_serializer: ViewerSerializer
    # end
    render json: Spot.all, each_serializer: SpotForecastSerializer
    # Spot.all.map {|spot|
    #   render json: spot
    #   # require 'pry'; binding.pry
    # }
    # json_response(Spot.with_forecast)
  end

  private
  # def set_spot
  #   @spot = Spot.find_by(spitcast_id: params[:spitcast_id])
  # end

  # def create_service
  #   @service ||= @spot ? SpitCastService.new(@spot.spitcast_id) : (json_response({error: "route not found"}, :not_found))
  # end
end