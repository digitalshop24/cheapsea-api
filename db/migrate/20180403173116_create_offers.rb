class CreateOffers < ActiveRecord::Migration[5.0]
  def change
    create_table :offers do |t|
      t.integer :offer_type
      t.integer :discount_type
      t.string :name
      t.integer :from_google_place_id
      t.integer :to_google_place_id
      t.integer :airline_id
      t.integer :flight_type
      t.integer :transfers_count
      t.datetime :date_from
      t.datetime :date_to
      t.datetime :date_end
      t.integer :price
      t.integer :currency_type
      t.integer :discount_rate
      t.text :description

      t.timestamps
    end
  end
end
