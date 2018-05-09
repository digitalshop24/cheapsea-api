class AddColumns < ActiveRecord::Migration[5.1]
  def change
    add_reference :offers, :images_countries_square, index: true
    add_reference :offers, :images_countries_rectangular, index: true
  end
end
