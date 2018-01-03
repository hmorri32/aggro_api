FactoryBot.define do
  factory :spot do
    name Faker::Hipster.name
    lat  Faker::Address.latitude
    lon  Faker::Address.longitude
    surfline_id 4980
    msw_id      2646
    spitcast_id 191
  end
end

# t.string   "name"
# t.float    "lat"
# t.float    "lon"
# t.integer  "surfline_id"
# t.integer  "msw_id"
# t.integer  "spitcast_id"