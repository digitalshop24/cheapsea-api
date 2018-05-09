class AddCityToTransfers < ActiveRecord::Migration[5.1]
  def change
    add_reference :transfers, :city
  end
end
