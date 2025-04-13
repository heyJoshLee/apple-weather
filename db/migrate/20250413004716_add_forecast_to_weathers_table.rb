class AddForecastToWeathersTable < ActiveRecord::Migration[7.2]
  def change
    add_column :addresses, :forecast, :jsonb, default: {}
  end
end
