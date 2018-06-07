class CreateOffers < ActiveRecord::Migration[5.0]
  def change
    create_table :offers do |t|
      t.integer :offer_type
      t.integer :discount_type
      t.string :name
      t.integer :airline_id, index: true, foreign_key: true
      t.boolean :is_direct, default: true
      t.integer :transfers_count
      t.datetime :date_from, index: true
      t.datetime :date_to, index: true
      t.datetime :date_end
      t.integer :discount_rate
      t.text :description
      t.integer :status, default: 'draft', null: false, index: true
      t.integer :user_id, index: true, foreign_key: true
      t.float :price
      t.string :price_currency, default: 'RUB'
      t.boolean :two_sides, default: false, null: false, index: true
      t.integer :flight_number, index: true
      t.string :gate
      t.integer :origin_id, foreign_key: true, index: true
      t.integer :destination_id, foreign_key: true, index: true
      t.integer :from_airport_id, foreign_key: true, index: true
      t.integer :to_airport_id, foreign_key: true, index: true
      t.integer :visits_count, default: 0, null: false
      t.string :name_auto
      t.integer :quality, default: 'unknown', null: false
      t.json :statistic, null: false, default: '{}'
      t.boolean :main, default: false, null: false
      t.text :faq

      t.timestamps
    end
  end
end
