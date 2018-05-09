class CreateOfferTags < ActiveRecord::Migration[5.1]
  def change
    create_table :offer_tags do |t|
      t.references :offer, foreign_key: true, null: false
      t.references :tag, foreign_key: true, null: false
      t.references :user, foreign_key: true

      t.timestamps
    end

    add_index :offer_tags, [:offer_id, :tag_id], unique: true
  end
end
