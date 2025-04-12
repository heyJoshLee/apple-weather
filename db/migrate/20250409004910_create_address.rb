class CreateAddress < ActiveRecord::Migration[7.2]
  def change
    create_table :addresses do |t|
      t.timestamps
      t.string :street
      t.string :city
      t.string :postal_code
      t.string :state_code
      t.string :country_code
      t.string :formatted_address
      t.string :latitude
      t.string :longitude
      t.datetime :last_api_call
    end
  end
end
