class CreateStocks < ActiveRecord::Migration
  def change
    create_table :stocks do |t|

      t.timestamps null: false
    end
  end
end
