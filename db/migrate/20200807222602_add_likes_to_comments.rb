class AddLikesToComments < ActiveRecord::Migration[6.0]
  def change
    add_column :comments, :likes, :integer, :null => false, :default => 0
  end
end
