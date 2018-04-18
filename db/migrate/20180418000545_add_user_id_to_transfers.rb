class AddUserIdToTransfers < ActiveRecord::Migration[5.0]
  def change
    Transfer.destroy_all
    add_column :transfers, :user_id, :integer, foreign_key: true, null: false
  end
end
