class AddLastPriceToStocks < ActiveRecord::Migration
  def change
    add_column :stocks, :last_price, :float
  end
end
