class Bidding < ActiveRecord::Base
	attr_accessible :interested

	belongs_to :user
	belongs_to :company
	
	def employer
	  User.find(self.employer_id)
  end
  
  def seeker
    User.find(self.seeker_id)
  end
end
