class CreateTransfers < ActiveRecord::Migration[5.0]
  def change
    create_table :transfers do |t|
      t.references :offer, foreign_key: true, null: false
      t.string :google_place_id
      t.references :airline, foreign_key: true

      t.timestamps
    end
  end
end
