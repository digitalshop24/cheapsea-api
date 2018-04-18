class CreateTransfers < ActiveRecord::Migration[5.0]
  def change
    create_table :transfers do |t|
      t.references :offer, foreign_key: true, null: false
      t.string :google_place_id
      t.references :airline, foreign_key: true
      t.references :user, foreign_key: true, null: false

      t.timestamps
    end
  end
end
