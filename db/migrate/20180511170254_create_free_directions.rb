class CreateFreeDirections < ActiveRecord::Migration[5.1]
  def change
    create_table :free_directions do |t|
      t.integer :origin_id, foreign_key: true, null: false
      t.integer :destination_id, foreign_key: true, null: false

      t.timestamps
    end

    add_index :free_directions, [:origin_id, :destination_id], unique: true
  end
end
