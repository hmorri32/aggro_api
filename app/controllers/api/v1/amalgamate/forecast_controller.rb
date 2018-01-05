class Api::V1::Amalgamate::ForecastController < Api::V1::BaseController
  def weekly_forecast
    if params[:name]
      @spot = Spot.where("name ILIKE ?", "%#{params[:name]}%")
      if @spot.length > 0
        @service = AmalgamatedService.new(@spot.first)
        json_response @service.spitcast_weekly
      else
        not_found
      end
    else
      params_formatting_error
    end
  end

  private
    def params_formatting_error
      json_response({ message: "Missing params. This endpoint is hit like /api/v1/amalgamate/weekly_forecast/:name"}, :not_found)
    end

    def not_found
      json_response({ message: "Resource not found."}, :not_found)
    end
end