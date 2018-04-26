class AddColumnsToOffers < ActiveRecord::Migration[5.1]
  def change
    add_column :offers, :origin_id, :integer, foreign_key: true, index: true
    add_column :offers, :destination_id, :integer, foreign_key: true, index: true
  end
end
