class CreateAddress < ActiveRecord::Migration[7.2]
  def change
    create_table :addresses do |t|
      t.timestamps
      t.string :zip_code
      t.datetime :last_api_call
    end
  end
end
