class AmalgamatedService
  attr_reader :msw_servce, :spitcast_service, :surfline_service
  def initialize(spot)
    @msw_service      = MswService.new(spot.msw_id)
    @spitcast_service = SpitCastService.new(spot.spitcast_id)
    @surfline_service = SurflineService.new(spot.surfline_id)
  end

  def surfline_weekly
    surfline_service.parsed_response(7)
  end

  def spitcast_weekly
    spitcast_service.weekly_forecast
  end

  def parse_spitcast_weekly
  end

  def time_zone
    ActiveSupport::TimeZone.new("Pacific Time (US & Canada)")
  end
end

# var data = [{"date":"2010-01-01","price":30},{"date":"2010-02-01","price":40},{"date":"2010-03-01","price":50},{"date":"2010-01-01","price2":45},{"date":"2010-05-01","price2":40},{"date":"2010-10-01","price2":50}]

# data.sort((a, b) => new Date(a.date) - new Date(b.date))

# var result = []
# data.forEach(function(e) {
#   if(!this[e.date]) {
#     this[e.date] = {date: e.date, price: null, price2: null}
#     result.push(this[e.date])
#   }
#   this[e.date] = Object.assign(this[e.date], e)
# })