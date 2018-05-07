class CreateOfferCollections < ActiveRecord::Migration[5.1]
  def change
    create_table :offer_collections do |t|
      t.references :offer, null: false
      t.references :collection, null: false
      t.references :user

      t.timestamps
    end

    add_index :offer_collections, [:offer_id, :collection_id], unique: true
  end
end
