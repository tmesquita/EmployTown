class AddContactNameToBids < ActiveRecord::Migration
  def change
    add_column :bids, :contact_name, :string
  end
end
