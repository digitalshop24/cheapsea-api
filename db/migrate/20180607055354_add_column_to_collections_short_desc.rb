class AddColumnToCollectionsShortDesc < ActiveRecord::Migration[5.1]
  def change
    # TODO remove
    add_column :collections, :short_desc, :text
  end
end
