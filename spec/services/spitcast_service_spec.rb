require 'rails_helper'

RSpec.describe SpitCastService do
  let!(:spitcast) { SpitCastService.new }

  describe "initialize" do
    it 'returns an instance' do
      expect(spitcast).to be_a SpitCastService
    end
  end

  describe "instance methods" do
    describe "weekly_forecast" do
      it "returns a 7 day forecast" do
        forecast = spitcast.weekly_forecast
        expect(forecast.class).to eq Array
        expect(forecast.length).to eq 169
      end
    end

    describe "daily_forecast" do
      it "returns a daily forecast" do
        forecast = spitcast.daily_forecast
        expect(forecast.class).to eq Array
        expect(forecast.length).to eq 25
      end
    end
  end

  describe "class methods" do
    describe "daily_san_diego_tides" do
      it "returns daily tides for san diego county" do
        forecast = SpitCastService.daily_san_diego_tides
        expect(forecast.class).to eq Array
        expect(forecast.length).to eq 25
      end
    end

    describe "weekly_san_diego_tides" do
      it "returns weekly tides for san diego county" do
        forecast = SpitCastService.weekly_san_diego_tides
        expect(forecast.class).to eq Array
        expect(forecast.length).to eq 169
      end
    end
  end
end