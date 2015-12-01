class AddAncestryDepthToComment < ActiveRecord::Migration
  def change
    add_column :comments, :ancestry_depth, :integer, default: 0
  end
end
