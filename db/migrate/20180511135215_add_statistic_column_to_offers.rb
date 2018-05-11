class AddStatisticColumnToOffers < ActiveRecord::Migration[5.1]
  def change
    # TODO remove
    add_column :offers, :statistic, :json, null: false, default: '{}'
  end
end
