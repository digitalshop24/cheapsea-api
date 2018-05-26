class AddColumnsToCountry < ActiveRecord::Migration[5.1]
  def change
    add_column :countries, :police_phone_number, :string
    add_column :countries, :ambulance_phone_number, :string
    add_column :countries, :inoculations, :boolean, default: false, null: false
    add_column :countries, :snakes, :boolean, default: false, null: false
    add_column :countries, :thieves, :boolean, default: false, null: false
    add_column :countries, :queer_money, :boolean, default: false, null: false
  end
end
