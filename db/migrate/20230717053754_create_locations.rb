class CreateLocations < ActiveRecord::Migration[7.0]
  def change
    create_table :locations do |t|
      t.references :user, null: false, foreign_key: true
      t.string :ip_address
      t.string :address_1
      t.string :address_2
      t.string :city
      t.string :state
      t.string :zip
      t.string :country
      t.string :latitude
      t.string :longitude

      t.timestamps
    end
  end
end
