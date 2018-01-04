require 'rails_helper'

RSpec.describe "api/v1/spitcast/", type: :request do
  let!(:blacks)   { create(:spot) }
  let!(:spitcast) { SpitCastService.new(blacks) }

  describe 'GET api/v1/spitcast/daily/:id' do
    context "given valid resource" do
      it "returns a daily surf forecast" do
        get "/api/v1/spitcast/daily/#{blacks.spitcast_id}"

      end
    end
  end
end