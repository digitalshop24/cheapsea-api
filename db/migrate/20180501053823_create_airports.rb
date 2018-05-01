class CreateAirports < ActiveRecord::Migration[5.1]
  def change
    create_table :airports do |t|
      t.string :name, null: false
      t.string :name_en, null: false
      t.references :city, null: false
      t.string :iata, null: false
      t.boolean :flightable, null: false, default: false
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
