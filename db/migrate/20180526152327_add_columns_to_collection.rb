class AddColumnsToCollection < ActiveRecord::Migration[5.1]
  def change
    # TODO delete
    add_column :collections, :status, :integer, default: 'draft', null: false
    add_column :collections, :published_at, :datetime
    add_column :collections, :main, :boolean, default: false, null: false
  end
end
