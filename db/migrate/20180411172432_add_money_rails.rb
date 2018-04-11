class AddMoneyRails < ActiveRecord::Migration[5.0]
  def change
    change_table :offers do |t|
      t.monetize :price # Rails 4x and above
    end
    remove_column :offers, :currency_type
  end
end
