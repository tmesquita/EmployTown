class Bidding < ActiveRecord::Base
	belongs_to :user
	belongs_to :company
	
	def employer
	  User.find(self.employer_id)
  end
end
