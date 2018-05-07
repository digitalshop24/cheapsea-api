class CreateCollections < ActiveRecord::Migration[5.1]
  def change
    create_table :collections do |t|
      t.string :name, null: false
      t.string :name_en
      t.text :desc
      t.references :user

      t.timestamps
    end
  end
end
