class CreateCountries < ActiveRecord::Migration[5.1]
  def change
    create_table :countries do |t|
      t.string :iata, null: false
      t.string :name, null: false
      t.string :name_en, null: false

      t.timestamps
    end
  end
end
