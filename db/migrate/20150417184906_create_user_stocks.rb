class CreateUserStocks < ActiveRecord::Migration
  def change
    create_table :user_stocks do |t|
      t.references :user, index: true
      t.references :stock, index: true

      t.timestamps null: false
    end
    add_foreign_key :user_stocks, :users
    add_foreign_key :user_stocks, :stocks
  end
end
