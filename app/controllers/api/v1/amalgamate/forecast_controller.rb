class Api::V1::Amalgamate::ForecastController < Api::V1::BaseController
  def weekly_forecast
    render json: { cool: params[:name] }
  end
end