class CreateListItems < ActiveRecord::Migration
  def change
    create_table :list_items do |t|
      t.references :item
      t.references :list
      t.timestamps null: false
    end
  end
end
