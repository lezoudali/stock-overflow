class AddListIdToUsers < ActiveRecord::Migration
  def change
    add_reference :users, :list, index: true
    add_foreign_key :users, :lists
  end
end
