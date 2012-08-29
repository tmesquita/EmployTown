class Bid < ActiveRecord::Base
	attr_accessible :interested_flag, :comment, :job_title, :salary, :contact_name, :contact_email, :salary_term, :job_description

  belongs_to :employer
  belongs_to :job_seeker

  validates_presence_of :job_title, :contact_email, :contact_name, :salary
  validates_numericality_of :salary

  def self.not_responded
    where(:interested_flag => nil)
  end

  def self.interested
    where(:interested_flag => true)
  end

  def self.not_interested
    where(:interested_flag => false)
  end

  def accepted?
    interested_flag
  end

  def declined?
    !interested_flag && !interested_flag.nil?
  end

  def not_responded?
    interested_flag.nil?
  end
end
