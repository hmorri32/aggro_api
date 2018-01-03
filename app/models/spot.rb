class Spot < ApplicationRecord
  # def self.create_spit_reports
  #   self.where.not(spitcast_id: nil).map do |spot|
  #     SpitCastService.new(spot[:spitcast_id]).weekly_forecast
  #   end.flatten
  # end
end