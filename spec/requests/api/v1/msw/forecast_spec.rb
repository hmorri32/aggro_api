require 'rails_helper'

RSpec.describe "api/v1/msw/", type: :request do
  let!(:blacks) { create(:spot) }
  let!(:msw)    { MswService.new(blacks) }

  describe 'GET api/v1/msw/weekly/:id' do
    context "given valid resource" do
      before { get "/api/v1/msw/weekly/#{blacks.msw_id}" }
      it "returns a weekly surf forecast" do
        expect(json).to_not be_empty
        expect(json.class).to be Array
        expect(json.length).to eq 40
      end

      it "returns HTTP status code 200" do
        expect(response).to have_http_status(200)
      end
    end

    context "given an invalid resource" do
      before { get "/api/v1/msw/weekly/22222" }
      it "returns an error message" do
        expect(response.body).to match(/route not found/)
      end

      it "returns http status code 404" do
        expect(response).to have_http_status(404)
      end
    end
  end
end