class CreateForumThreads < ActiveRecord::Migration
  def change
    create_table :forum_threads do |t|
      t.references :user, index: true
      t.string :subject

      t.timestamps null: false
    end
    add_foreign_key :forum_threads, :users
  end
end
