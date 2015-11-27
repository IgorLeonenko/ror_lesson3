class RemoveDislikeFromLikes < ActiveRecord::Migration
  def up
    remove_column :likes, :dislike
  end

  def down
    add_column :likes, :dislike, :boolean
  end
end
