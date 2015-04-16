class ChangeOriginalPriceInItemsFloat < ActiveRecord::Migration
  def up
    change_column :items, :original_price, :float
  end

  def down 
    change_column :items, :original_price, :decimal
  end
end
