class AddColumnQualityToOffers < ActiveRecord::Migration[5.1]
  def change
    # TODO remove
    add_column :offers, :quality, :integer, default: 'unknown', null: false
  end
end
