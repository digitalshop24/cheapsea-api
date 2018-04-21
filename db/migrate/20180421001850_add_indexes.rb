class AddIndexes < ActiveRecord::Migration[5.0]
  # TODO delete
  def change
    add_index :offers, :date_from
    add_index :offers, :date_to
  end
end
