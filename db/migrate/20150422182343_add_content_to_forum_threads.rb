class AddContentToForumThreads < ActiveRecord::Migration
  def change
    add_column :forum_threads, :content, :text
  end
end
