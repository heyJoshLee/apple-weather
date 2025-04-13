class Change < ActiveRecord::Migration[7.2]
  def change
    rename_column :addresses, :zip_code, :postal_code
  end
end
