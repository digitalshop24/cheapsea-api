class AddUserIdToTransfers < ActiveRecord::Migration[5.0]
  def change
    add_column :transfers, :user_id, :integer, foreign_key: true, null: false
  end
end
