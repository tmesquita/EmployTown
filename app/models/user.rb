class User < ActiveRecord::Base
  authenticates_with_sorcery!

  belongs_to :role
  has_many :tags
  
  attr_accessible :email, :password, :password_confirmation, :role_id, :first_name, :last_name, :seeking, :user_url, :photo, :resume, :company_id, :about_me, :ideal_role
  attr_accessible :facebook_flag, :twitter_flag, :blog_flag, :blog_address, :facebook, :twitter, :contact_email, :contact_phone

  before_validation :remove_non_digits_in_phone
  
  validates :email, :presence => true, :uniqueness => true
  validates :password, :confirmation => true, :presence => true, :on => :create
  validates_presence_of :first_name, :last_name
  validates_attachment_content_type :resume, :content_type => ['application/msword', 'application/pdf', 'application/rtf', 'text/plain', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document']
  validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/jpg', 'image/png', 'image/gif']
  validates :user_url, :presence => true, :uniqueness => true, :on => :update

  default_scope :include => :role
  before_create :assign_default_url

  before_save :remove_http_from_blog

  validates_format_of :contact_email,
      :message => 'must look like an email address',
      :with => /\b[a-zA-Z0-9._%-]+@[a-zA-Z0-9_.-]+\.[a-zA-Z]{2,4}\b/,
      :on => :update,
      :allow_blank => true
  
  validates_format_of :user_url,
      :message => 'can only contain numbers, letters, and underscores',
      :with => /^[\w]+$/,
      :on => :update

  validates_format_of :contact_phone,
      :message => "must be 10 digits long and only contain digits",
      :with => /^[\(\)0-9\- \+\.]{10}$/,
      :allow_blank => true

  # validates_format_of :facebook, :twitter, :blog_address,
  #     :message => 'URL must look like a url',
  #     :with => /[a-zA-Z0-9]+[^w\.]\.[a-zA-Z0-9]+\/?[a-zA-Z0-9]*/,
  #     :allow_blank => true,
  #     :on => :update

  has_attached_file :photo, 
                    :styles => { :thumb => "50x50>", :small => "150x150>", :regular => "300x300>" },
                    :url => "/assets/:class/:attachment/:id/:style.:extension",
                    :path => ":rails_root/public/system/:class/:attachment/:id_partition/:style/:filename",
                    :default_url => "default_profile.jpg",
                    :storage => :s3,
                    :s3_credentials => "#{Rails.root}/config/s3.yml"
                    
  has_attached_file :resume,
                    :url => "/assets/:class/:attachment/:id/:style.:extension",
                    :path => ":rails_root/public/system/:class/:attachment/:id_partition/:style/:filename",
                    :storage => :s3,
                    :s3_credentials => "#{Rails.root}/config/s3.yml"

  HUMANIZED_ATTRIBUTES = {
    :user_url => "Profile URL"
  }

  def self.human_attribute_name(attr, options = {})
    HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  end
  
  def is_job_seeker?
    self.is_a? JobSeeker
  end
  
  def is_employer?
    self.is_a? Employer
  end
  
  def to_s
    "#{first_name} #{last_name}"
  end
  
  def role_symbols
    [role.name.downcase.to_sym]
  end

  def self.search(search)
      search.upcase
      if ActiveRecord::Base.connection.instance_variable_get(:@config)[:database].split('/').last.eql? "development.sqlite3"
        where(type: 'JobSeeker').where("first_name LIKE UPPER(?) OR last_name LIKE UPPER(?) OR first_name || ' ' || last_name LIKE UPPER(?) OR email LIKE UPPER(?)", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%")
      else
        where(type: 'JobSeeker').where("first_name ILIKE UPPER(?) OR last_name ILIKE UPPER(?) OR first_name || ' ' || last_name ILIKE UPPER(?) OR email ILIKE UPPER(?)", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%")
      end
  end

  def get_tag_count
    Tag.count(:conditions => {:user_id => self.id})
  end

  def has_facebook_enabled?
    facebook_flag
  end

  def has_twitter_enabled?
    twitter_flag
  end

  def has_blog_enabled?
    blog_flag
  end
  
  def belongs_to_company?
    !company.nil?
  end

  def has_resume?
    !resume_file_name.nil?
  end

  protected

    def remove_http_from_blog
      self.blog_address.gsub!('http://', '') unless self.blog_address.blank?
    end
  
    def remove_non_digits_in_phone
      self.contact_phone.gsub!(/\D/, "") unless self.contact_phone.blank?
    end
  
    def assign_default_url
      self.user_url = rand(2**256).to_s(36)[0..15]
    end
end
