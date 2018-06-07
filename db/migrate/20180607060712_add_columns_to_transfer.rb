class AddColumnsToTransfer < ActiveRecord::Migration[5.1]
  def change
    add_column :transfers, :to_airline_id, :integer, index: true, foreign_key: true
    add_column :transfers, :airport_id, :integer, index: true, foreign_key: true
    add_column :transfers, :to_airport_id, :integer, index: true, foreign_key: true
    add_column :transfers, :to_city_id, :integer, index: true, foreign_key: true
    add_column :transfers, :type, :integer, default: 'from_origin'
    add_column :transfers, :number, :integer
  end
end
