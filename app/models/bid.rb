class Bid < ActiveRecord::Base
	attr_accessible :interested_flag, :comment, :job_title, :salary, :contact_email, :salary_term, :job_description

	belongs_to :user
  belongs_to :employer
  belongs_to :job_seeker
	belongs_to :company

  validates :job_title, :presence => true
  validates :salary, :presence => true, :numericality => true
  validates :contact_email, :presence => true

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
