class AddForecastToSpot < ActiveRecord::Migration[5.1]
  def change
    add_column :spots, :forecast, :json
  end
end
