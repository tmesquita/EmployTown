class CreateBiddings < ActiveRecord::Migration
  def self.up
    create_table :biddings do |t|
      t.integer :employer_id
      t.integer :seeker_id
      t.date :date
      t.integer :interested
      t.string :description
      t.string :job_title
      t.string :salary
      t.string :contact_email
      t.string :contact_name


      t.timestamps
    end
  end

  def self.down
    drop_table :biddings
  end
end
