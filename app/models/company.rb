class Company < ActiveRecord::Base

	has_many :biddings
	has_many :users

  validate :validate_urls, :on => :update
	
	def to_s
	  self.name.titleize
  end

  def has_facebook_enabled?
    self.facebook_enabled_flag
  end

  def has_twitter_enabled?
    self.twitter_enabled_flag
  end

  def has_blog_enabled?
    self.blog_enabled_flag
  end

  def validate_urls
    unless self.facebook.blank?
      if !self.facebook.match( /[a-zA-Z0-9]+[^w\.]\.[a-zA-Z0-9]+\/?[a-zA-Z0-9]*/)
        errors.add(:facebook, 'URL must look like a url')
      end
    end

    unless self.twitter.blank?
      if !self.twitter.match( /[a-zA-Z0-9]+[^w\.]\.[a-zA-Z0-9]+\/?[a-zA-Z0-9]*/)
        errors.add(:twitter, 'URL must look like a url')
      end
    end

    unless self.blog_address.blank?
      if !self.blog_address.match( /[a-zA-Z0-9]+[^w\.]\.[a-zA-Z0-9]+\/?[a-zA-Z0-9]*/)
        errors.add(:blog_address, 'must look like a url')
      end
    end
  end
end
