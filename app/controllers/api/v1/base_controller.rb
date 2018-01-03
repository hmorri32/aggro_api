class Api::V1::BaseController < ApplicationController
  def welcome
    render json: { 'coolguy': true }
  end
end