class AddLikesToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :likes, :integer, :null => false, :default => 0
  end
end
