class CreateCityCodes < ActiveRecord::Migration[5.0]
  def change
    create_table :city_codes do |t|
      t.string :iata, null: false
      t.string :name, null: false

      t.timestamps
    end
  end
end
