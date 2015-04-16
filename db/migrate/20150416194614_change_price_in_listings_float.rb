class ChangePriceInListingsFloat < ActiveRecord::Migration
  def up
    change_column :listings, :price, :float
  end

  def down 
    change_column :listings, :price, :decimal
  end
end
