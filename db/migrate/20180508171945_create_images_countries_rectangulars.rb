class CreateImagesCountriesRectangulars < ActiveRecord::Migration[5.1]
  def change
    create_table :images_countries_rectangulars do |t|
      t.references :country, foreign_key: true
      t.string :file

      t.timestamps
    end
  end
end
