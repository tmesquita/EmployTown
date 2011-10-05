class CreateBiddings < ActiveRecord::Migration
  def self.up
    create_table :biddings do |t|
      t.integer :employer_id
      t.integer :seeker_id
      t.date :date
      t.integer :interested

      t.timestamps
    end
  end

  def self.down
    drop_table :biddings
  end
end
