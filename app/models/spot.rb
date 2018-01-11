class Spot < ApplicationRecord


  def with_forecast(id)
    Rails.cache.fetch('#{cache_key}/with_forecast', expires_in: 12.hours) do
      service = SpitCastService.new(id)
      # require 'pry'; binding.pry
      stuff = service.weekly_forecast
    end
  end
end