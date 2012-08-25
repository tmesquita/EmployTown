class Company < ActiveRecord::Base

  attr_accessible :name, :description, :looking_for, :why_work_for, :facebook_flag, :facebook, :twitter, :blog_address, :company_url, :logo

	has_many :bids
	has_many :employers

  validates :name, :presence => true

  validates_attachment_content_type :logo, :content_type => ['image/jpeg', 'image/jpg', 'image/png', 'image/gif']

  has_attached_file :logo,
                    :styles => { :thumb => "50x50>", :small => "150x150>", :regular => "300x300>" },
                    :url => "/assets/:class/:attachment/:id/:style.:extension",
                    :path => ":rails_root/public/system/:class/:attachment/:id_partition/:style/:filename",
                    :default_url => "default_profile.jpg",
                    :storage => :s3,
                    :s3_credentials => "#{Rails.root}/config/s3.yml"

  # validates_format_of :facebook, :twitter, :blog_address, :company_url,
  #     :message => 'URL must look like a url',
  #     :with => /(www\.)*[a-zA-Z0-9]+\.[a-zA-Z0-9]+\/?[a-zA-Z0-9]*/,
  #     :allow_blank => true,
  #     :on => :update

  HUMANIZED_ATTRIBUTES = {
    :name => 'Company name'
  }

  def self.human_attribute_name(attr, options = {})
    HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  end
	
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
