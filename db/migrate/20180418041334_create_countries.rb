class CreateCountries < ActiveRecord::Migration[5.1]
  def change
    create_table :countries do |t|
      t.string :iata, null: false
      t.string :name, null: false
      t.string :name_en, null: false
      t.text :desc
      t.references :continent
      t.string :police_phone_number
      t.string :ambulance_phone_number
      t.boolean :inoculations, default: false, null: false
      t.boolean :snakes, default: false, null: false
      t.boolean :thieves, default: false, null: false
      t.boolean :queer_money, default: false, null: false

      t.timestamps
    end
  end
end
