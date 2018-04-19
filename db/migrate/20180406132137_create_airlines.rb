class CreateAirlines < ActiveRecord::Migration[5.0]
  def change
    create_table :airlines do |t|
      t.string :name, index: true, null: false
      t.string :iata, index: true

      t.timestamps
    end
  end
end
