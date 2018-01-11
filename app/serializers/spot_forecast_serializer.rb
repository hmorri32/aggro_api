class SpotForecastSerializer < ActiveModel::Serializer
  attributes :id, :name, :spitcast_id, :forecast
  cache key: 'forecast', expires_in: 5.hours

  def forecast
    if object.spitcast_id
      object.with_forecast(object.spitcast_id)
    end
  end
end