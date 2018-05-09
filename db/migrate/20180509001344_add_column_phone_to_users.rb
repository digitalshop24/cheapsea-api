class AddColumnPhoneToUsers < ActiveRecord::Migration[5.1]
  def change
    # TODO remove
    add_column :users, :phone, :string
  end
end
