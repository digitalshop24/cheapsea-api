class AddGateColumnToOffers < ActiveRecord::Migration[5.1]
  def change
    add_column :offers, :gate, :string
  end
end
