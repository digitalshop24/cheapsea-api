class RemoveDeviseShit < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :provider
    remove_column :users, :uid

    ## Database authenticatable
    remove_column :users, :encrypted_password

    ## Recoverable
    remove_column :users, :reset_password_token
    remove_column :users, :reset_password_sent_at
    remove_column :users, :allow_password_change

    ## Rememberable
    remove_column :users, :remember_created_at

    ## Trackable
    remove_column :users, :sign_in_count
    remove_column :users, :current_sign_in_at
    remove_column :users, :last_sign_in_at
    remove_column :users, :current_sign_in_ip
    remove_column :users, :last_sign_in_ip

    ## Confirmable
    remove_column :users, :confirmation_token
    remove_column :users, :confirmed_at
    remove_column :users, :confirmation_sent_at
    remove_column :users, :unconfirmed_email # Only if using reconfirmable

    ## Lockable
    # t.integer  :failed_attempts # Only if lock strategy is :failed_attempts
    # t.string   :unlock_token # Only if unlock strategy is :email or :both
    # t.datetime :locked_at

    ## User Info
    remove_column :users, :name
    remove_column :users, :nickname
    remove_column :users, :image

    ## Tokens
    remove_column :users, :tokens
  end
end
