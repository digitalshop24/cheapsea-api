class Df < ActiveRecord::Migration[5.1]
  # TODO delete
  def change
    add_index :offers, :two_sides
  end
end
