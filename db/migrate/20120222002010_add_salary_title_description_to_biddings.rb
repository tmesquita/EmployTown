class AddSalaryTitleDescriptionToBiddings < ActiveRecord::Migration
  def self.up
    add_column :biddings, :salary, :string
    add_column :biddings, :title, :string
  end

  def self.down
    remove_column :biddings, :title
    remove_column :biddings, :salary
  end
end
