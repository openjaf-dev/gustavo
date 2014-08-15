class CreateSpreeLocations < ActiveRecord::Migration
  def change
    create_table :spree_locations do |t|
      t.string :address
      t.string :location_name
      t.string :phone_number
      t.string :distric
      t.string :city
      t.string :postcode
      t.string :country
      t.decimal :lat
      t.decimal :lng
      t.string :reference
      t.boolean :enabled

      t.timestamps
    end
  end
end
