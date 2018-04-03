class AddColumnStatusToOffers < ActiveRecord::Migration[5.0]
  def change
    add_column :offers, :status, :integer, default: 0, null: false, index: true
    add_column :offers, :user_id, :integer, null: false, index: true, foreign_key: true
  end
end
