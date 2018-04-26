class CreateCities < ActiveRecord::Migration[5.0]
  def change
    create_table :cities do |t|
      t.string :iata, null: false
      t.string :name, null: false, index: true
      t.boolean :active, null: false, default: false, index: true

      t.timestamps
    end
  end
end
