class AddLikeDislikeToLike < ActiveRecord::Migration
  def change
    add_column :likes, :like, :boolean, default: false
    add_column :likes, :dislike, :boolean, default: false
  end
end
