class CreateInventoryItems < ActiveRecord::Migration
  def change
    create_table :inventory_items do |t|
      t.references :item
      t.references :inventory
      t.timestamps null: false
    end
  end
end
