class CreateCities < ActiveRecord::Migration[5.0]
  def change
    create_table :cities do |t|
      t.string :iata, null: false
      t.string :name, null: false, index: true
      t.boolean :active, null: false, default: false, index: true
      t.integer :country_id, null: false, index: true
      t.string :name_en, null: false
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
