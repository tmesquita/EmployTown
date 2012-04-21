class AddAttributesToCompanies < ActiveRecord::Migration
  def self.up
    add_column :companies, :looking_for, :text
    add_column :companies, :why_work_for, :text
  end

  def self.down
    remove_column :companies, :why_work_for
    remove_column :companies, :looking_for
  end
end
