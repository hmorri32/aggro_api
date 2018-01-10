class Api::V1::SpotsController < Api::V1::BaseController
  before_action :authenticate_request!
  def index
    json_response(Spot.all)
  end
end