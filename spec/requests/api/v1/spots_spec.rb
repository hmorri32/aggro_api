require 'rails_helper'

RSpec.describe "api/v1/spots", type: :request do
  let!(:spots) { create_list(:spot, 100) }

  describe "GET api/v1/spots" do
    it "returns a list of all spots" do
      get '/api/v1/spots'
      expect(json).to_not be_empty
      expect(json.first['name']).to eq(spots.first.name)
    end
  end
end