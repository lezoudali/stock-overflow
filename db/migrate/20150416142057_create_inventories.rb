class CreateInventories < ActiveRecord::Migration
  def change
    create_table :inventories do |t|
      t.references :user
      t.timestamps null: false
    end
  end
end
