class User < ActiveRecord::Base
  authenticates_with_sorcery!

  belongs_to :role
  has_many :tags
  
  attr_accessible :email, :password, :password_confirmation, :role_id, :first_name, :last_name, :seeking, :user_url, :photo, :resume, :photo_content_type, :company_id, :about_me, :ideal_role
  attr_accessible :facebook_flag, :twitter_flag, :blog_flag, :blog_address, :facebook, :twitter, :contact_email, :contact_phone

  before_validation :remove_non_digits_in_phone
  
  validates :password, :confirmation => true, :presence => true, :on => :create
  validates :email, :presence => true, :uniqueness => true
  validates_attachment :photo, :content_type => { content_type: 'image/jpeg', content_type: 'image/jpg', content_type: 'image/png', content_type: 'image/gif'}
  validates_attachment :resume, :content_type => { content_type: 'application/msword', content_type: 'application/pdf', content_type: 'application/rtf', content_type: 'text/plain'}
  validates :user_url, :presence => true, :uniqueness => true, :on => :update

  default_scope :include => :role
  before_create :assign_default_url

  validates_format_of :contact_email,
      :message => 'must look like an email address',
      :with => /\b[a-zA-Z0-9._%-]+@[a-zA-Z0-9_.-]+\.[a-zA-Z]{2,4}\b/,
      :on => :update,
      :allow_blank => true
  
  validates_format_of :user_url,
      :message => 'can only contain numbers, letters, underscores, and periods',
      :with => /^[\w\.]+$/,
      :on => :update

  validates_format_of :contact_phone,
      :message => "must be 10 digits long and only contain digits",
      :with => /^[\(\)0-9\- \+\.]{10}$/,
      :allow_blank => true

  validates_format_of :facebook, :twitter, :blog_address,
      :message => 'URL must look like a url',
      :with => /[a-zA-Z0-9]+[^w\.]\.[a-zA-Z0-9]+\/?[a-zA-Z0-9]*/,
      :allow_blank => true,
      :on => :update

  has_attached_file :photo, 
                    :styles => { :thumb => "150x150>", :regular => "300x300>" },
                    :url => "/assets/:class/:attachment/:id/:style.:extension",
                    :path => "#{Rails.root}/public/assets/:class/:attachment/:id/:style.:extension",
                    :default_url => "default_profile.jpg",
                    :storage => :s3,
                    :s3_credentials => "#{Rails.root}/config/s3.yml"
                    
  has_attached_file :resume,
                    :url => "/assets/:class/:attachment/:id/:style.:extension",
                    :path => "#{Rails.root}/public/assets/:class/:attachment/:id/:style.:extension",
                    :storage => :s3,
                    :s3_credentials => "#{Rails.root}/config/s3.yml"
  
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

  def self.search(search, page)
      search.upcase
      if ActiveRecord::Base.connection.instance_variable_get(:@config)[:database].split('/').last.eql? "development.sqlite3"
        where(type: 'JobSeeker').where("first_name LIKE UPPER(?) OR last_name LIKE UPPER(?) OR first_name || ' ' || last_name LIKE UPPER(?) OR email LIKE UPPER(?)", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%").paginate(:page => page, :per_page => 2)
      else
        where(type: 'JobSeeker').where("first_name ILIKE UPPER(?) OR last_name ILIKE UPPER(?) OR first_name || ' ' || last_name ILIKE UPPER(?) OR email ILIKE UPPER(?)", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%").paginate(:page => page, :per_page => 2)
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
  
    def remove_non_digits_in_phone
      self.contact_phone.gsub!(/\D/, "") unless self.contact_phone.blank?
    end
  
    def assign_default_url
      self.user_url = rand(2**256).to_s(36)[0..15]
    end
end
