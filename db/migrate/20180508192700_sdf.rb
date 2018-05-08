class Sdf < ActiveRecord::Migration[5.1]
  def change
    # TODO remove
    remove_column :offers, :from_google_place_id
    remove_column :offers, :to_google_place_id
    remove_column :transfers, :google_place_id
    add_reference :transfers, :city
  end
end
