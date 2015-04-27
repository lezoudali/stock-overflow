class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :text
      t.string :url
      t.references :stock, index: true

      t.timestamps null: false
    end
    add_foreign_key :tweets, :stocks
  end
end
