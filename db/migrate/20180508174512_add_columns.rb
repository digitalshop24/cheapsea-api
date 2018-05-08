class AddColumns < ActiveRecord::Migration[5.1]
  def change
    # TODO delete desc
    add_column :countries, :desc, :text

    add_reference :offers, :images_countries_square, index: true
    add_reference :offers, :images_countries_rectangular, index: true
  end
end
