class Dsf < ActiveRecord::Migration[5.1]
  # TODO delete
  def change
    add_index :cities, :name
  end
end
