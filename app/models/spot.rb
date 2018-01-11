class Spot < ApplicationRecord


  def with_forecast(id)
    service = SpitCastService.new(id)
    # require 'pry'; binding.pry
    stuff = service.weekly_forecast
  end
end