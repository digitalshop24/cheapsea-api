class AddColumnsToOffers < ActiveRecord::Migration[5.1]
  def change
    # TODO remove
    add_column :offers, :main, :boolean, default: false, null: false
  end
end
