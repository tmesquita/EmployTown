class AddContactEmailToBiddings < ActiveRecord::Migration
  def self.up
    add_column :biddings, :contact_email, :string
  end

  def self.down
    remove_column :biddings, :contact_email
  end
end
