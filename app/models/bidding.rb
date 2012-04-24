class Bidding < ActiveRecord::Base
	attr_accessible :interested, :comment, :title, :salary, :contact_email, :salary_term

	belongs_to :user
	belongs_to :company

  validates :title, :presence => true
  validates :salary, :presence => true, :numericality => true
  validates :contact_email, :presence => true
	
	def employer
	  User.find(self.employer_id)
  end
  
  def seeker
    User.find(self.seeker_id)
  end
end
