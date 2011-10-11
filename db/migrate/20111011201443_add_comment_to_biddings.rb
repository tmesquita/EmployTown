class AddCommentToBiddings < ActiveRecord::Migration
  def self.up
    add_column :biddings, :comment, :string
  end

  def self.down
    remove_column :biddings, :comment
  end
end
