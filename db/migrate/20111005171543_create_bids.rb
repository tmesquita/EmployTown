class CreateBids < ActiveRecord::Migration
  def self.up
    create_table :bids do |t|
      t.integer :employer_id
      t.integer :job_seeker_id
      t.text    :job_description
      t.string  :job_title
      t.string  :salary
      t.string  :salary_term
      t.boolean :interested_flag
      t.string  :contact_email

      t.timestamps
    end
  end

  def self.down
    drop_table :bids
  end
end
