require 'rails_helper'

RSpec.describe MswService do
  let!(:msw_service) { MswService.new }
  describe "initialize" do
    it 'returns an instance' do
      expect(msw_service).to be_a MswService
    end
  end

  describe "instance methods" do
    describe "five_day_forecast" do
      it "returns a yung five_day forecast" do
        forecast = msw_service.five_day_forecast

        expect(forecast.class).to eq Array
        expect(forecast.length).to eq 40
      end
    end
  end
end