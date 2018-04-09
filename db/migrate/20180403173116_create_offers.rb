class CreateOffers < ActiveRecord::Migration[5.0]
  def change
    create_table :offers do |t|
      t.integer :offer_type
      t.integer :discount_type
      t.string :name
      t.string :from_google_place_id
      t.string :to_google_place_id
      t.integer :airline_id, index: true, foreign_key: true
      t.boolean :is_direct, default: true
      t.integer :transfers_count
      t.datetime :date_from
      t.datetime :date_to
      t.datetime :date_end
      t.integer :price
      t.integer :currency_type
      t.integer :discount_rate
      t.text :description
      t.integer :status, default: 0, null: false, index: true
      t.integer :user_id, index: true, foreign_key: true

      t.timestamps
    end
  end
end
