class Company < ActiveRecord::Base

  attr_accessible :name, :description, :looking_for, :why_work_for, :facebook_flag, :facebook, :twitter_flag, :twitter, :blog_flag, :blog_address, :company_url

	has_many :bids
	has_many :employers

  validates :name, :presence => true

  validates_format_of :facebook, :twitter, :blog_address, :company_url,
      :message => 'URL must look like a url',
      :with => /(www\.)*[a-zA-Z0-9]+\.[a-zA-Z0-9]+\/?[a-zA-Z0-9]*/,
      :allow_blank => true,
      :on => :update
	
	def to_s
	  self.name.titleize
  end

  def has_facebook_enabled?
    self.facebook_flag
  end

  def has_twitter_enabled?
    self.twitter_flag
  end

  def has_blog_enabled?
    self.blog_flag
  end
end
