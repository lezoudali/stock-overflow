class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.references :item
      t.decimal :price, precision: 8, scale: 2
      t.timestamps null: false
    end
  end
end
