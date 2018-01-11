namespace :update_spot do
  task add_forecast_to_spot: :environment do
    Spot.all.each do |spot|
      next if !spot.spitcast_id
      @service = SpitCastService.new(spot.spitcast_id)
      @forecast = @service.weekly_forecast
      spot.update!(forecast: @forecast)
    end
    # OrderItem.all.each do |order_item|
    #   price = Item.find(order_item.item_id).price
    #   order_item.update(price: price)
    # end
  end
end