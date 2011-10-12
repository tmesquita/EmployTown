class Company < ActiveRecord::Base
	has_many :biddings
	has_many :users
	
	def to_s
	  self.name.titleize
  end
end
