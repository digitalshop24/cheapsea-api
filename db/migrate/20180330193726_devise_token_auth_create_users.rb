class DeviseTokenAuthCreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table(:users) do |t|
      t.string :name
      t.string :email
      t.integer :role, default: 'member'
      t.string :password_digest, null: false
      t.string :image
    end

    add_index :users, :email,                unique: true
  end
end
