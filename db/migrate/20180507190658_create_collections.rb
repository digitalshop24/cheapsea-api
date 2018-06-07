class CreateCollections < ActiveRecord::Migration[5.1]
  def change
    create_table :collections do |t|
      t.string :name, null: false
      t.string :name_en
      t.text :desc
      t.text :short_desc
      t.references :user
      t.integer :status, default: 'draft', null: false
      t.datetime :published_at
      t.boolean :main, default: false, null: false

      t.timestamps
    end
  end
end
