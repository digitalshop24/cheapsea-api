class AddColumnFaqToOffers < ActiveRecord::Migration[5.1]
  def change
    # TODO remove
    add_column :offers, :faq, :text
  end
end
