class Api::V1::SpotsController < Api::V1::BaseController
  def index
    json_response(Spot.all)
  end
end