class CreateTransfers < ActiveRecord::Migration[5.0]
  def change
    create_table :transfers do |t|
      t.references :offer, null: false
      t.string :google_place_id
      t.references :airline
      t.references :user, null: false

      t.timestamps
    end
  end
end
