class AddSalaryTermToBiddings < ActiveRecord::Migration
  def self.up
    add_column :biddings, :salary_term, :string
  end

  def self.down
    remove_column :biddings, :salary_term
  end
end
