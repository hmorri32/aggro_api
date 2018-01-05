require 'rails_helper'

RSpec.describe "api/v1/surfline/", type: :request do
  let!(:blacks)   { create(:spot) }
  let!(:surfline) { SurflineService.new(blacks) }

  describe 'GET api/v1/surfline/weekly/:id' do
    context "given valid resource" do
      before { get "/api/v1/surfline/daily/#{blacks.surfline_id}" }
      it "returns a daily surf forecast" do
        expect(json).to_not be_empty
        expect(json.class).to be Hash
      end

      it "returns HTTP status code 200" do
        expect(response).to have_http_status(200)
      end
    end

    context "given an invalid resource" do
      before { get "/api/v1/surfline/daily/22222" }
      it "returns an error message" do
        expect(response.body).to match(/route not found/)
      end

      it "returns http status code 404" do
        expect(response).to have_http_status(404)
      end
    end
  end

  describe "GET api/v1/surfline/weekly/:id" do
    context "given valid resource" do
      before { get "/api/v1/surfline/weekly/#{blacks.surfline_id}" }
      it "returns a weekly surf forecast" do
        expect(json).to_not be_empty
        expect(json.class).to be Hash
      end

      it "returns HTTP status code 200" do
        expect(response).to have_http_status(200)
      end
    end

    context "given an invalid resource" do
      before { get "/api/v1/surfline/weekly/22222" }
      it "returns an error message" do
        expect(response.body).to match(/route not found/)
      end

      it "returns http status code 404" do
        expect(response).to have_http_status(404)
      end
    end
  end

  describe "GET api/v1/surfline/daily/:id/parsed" do
    context "given valid resource" do
      before { get "/api/v1/surfline/daily/#{blacks.surfline_id}/parsed" }
      it "returns a parsed surf forecast" do
        expect(json).to_not be_empty
        expect(json.class).to be Hash
      end

      it "returns HTTP status code 200" do
        expect(response).to have_http_status(200)
      end
    end

    context "given an invalid resource" do
      before { get "/api/v1/surfline/daily/22222/parsed" }
      it "returns an error message" do
        expect(response.body).to match(/route not found/)
      end

      it "returns http status code 404" do
        expect(response).to have_http_status(404)
      end
    end
  end

  describe "GET api/v1/surfline/weekly/:id/parsed" do
    context "given valid resource" do
      before { get "/api/v1/surfline/weekly/#{blacks.surfline_id}/parsed" }
      it "returns a parsed surf forecast" do
        expect(json).to_not be_empty
        expect(json.class).to be Hash
      end

      it "returns HTTP status code 200" do
        expect(response).to have_http_status(200)
      end
    end

    context "given an invalid resource" do
      before { get "/api/v1/surfline/weekly/22222/parsed" }
      it "returns an error message" do
        expect(response.body).to match(/route not found/)
      end

      it "returns http status code 404" do
        expect(response).to have_http_status(404)
      end
    end
  end
end