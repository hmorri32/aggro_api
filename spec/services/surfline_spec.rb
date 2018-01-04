require 'rails_helper'


RSpec.describe SurflineService do
  let!(:surfline_service) { SurflineService.new }

  describe "initialize" do
    it 'returns an instance' do
      expect(surfline_service).to be_a SurflineService
    end
  end

  describe "instance methods" do
    describe "weekly_forecast" do
      it "returns a yung weekly forecast" do
        forecast = surfline_service.weekly_forecast
        # require 'pry'; binding.pry
        expect(forecast.class).to eq Hash
      end
    end

    describe "daily_forecast" do
      it "returns a yung weekly forecast" do
        forecast = surfline_service.daily_forecast
        expect(forecast.class).to eq Hash
      end
    end
  end
end