class RemoveGooglePlaceIdFromTransfer < ActiveRecord::Migration[5.1]
  def change
    # TODO remove
    remove_column :transfers, :google_place_id
  end
end
