class User < ActiveRecord::Base
  authenticates_with_sorcery!
  
  attr_accessible :email, :password, :password_confirmation, :role_id, :first_name, :last_name, :seeking, :user_url, :photo, :resume, :photo_content_type, :company_id, :about_me, :ideal_role
  attr_accessible :facebook_enabled_flag, :twitter_enabled_flag, :blog_enabled_flag, :blog_address, :facebook, :twitter, :contact_email, :contact_phone
  
  validates :password, :confirmation => true, :presence => true, :on => :create
  validates :email, :presence => true, :uniqueness => true
  validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/jpg', 'image/png', 'image/gif']
  validates_attachment_content_type :resume, :content_type => ['application/msword', 'application/pdf', 'application/rtf', 'text/plain']
  validates_presence_of :user_url, :on => :update
  validates_uniqueness_of :user_url, :on => :update
  validates_format_of :user_url,
      :message => 'can only contain numbers, letters, underscores, and periods',
      :with => /^[\w\.]+$/,
      :on => :update

  validates_format_of :contact_phone,
      :message => "must be 10 digits long and only contain digits",
      :with => /^[\(\)0-9\- \+\.]{10}$/,
      :allow_blank => true
  
  belongs_to :role
  belongs_to :company
  has_many :biddings
  has_many :tags
  
  default_scope :include => :role
  
  before_create :assign_role

  before_create :assign_default_url

  before_validation :remove_non_digits_in_phone

  validate :validate_urls, :on => :update
  
  has_attached_file :photo, 
                    :styles => { :thumb => "150x150>", :regular => "300x300>" },
                    :url => "/assets/:class/:attachment/:id/:style.:extension",
                    :path => "#{RAILS_ROOT}/public/assets/:class/:attachment/:id/:style.:extension",
                    :default_url => "/images/default_profile.jpg",
                    :storage => :s3,
                    :s3_credentials => "#{RAILS_ROOT}/config/s3.yml"
                    
  has_attached_file :resume,
                    :url => "/assets/:class/:attachment/:id/:style.:extension",
                    :path => "#{RAILS_ROOT}/public/assets/:class/:attachment/:id/:style.:extension",
                    :storage => :s3,
                    :s3_credentials => "#{RAILS_ROOT}/config/s3.yml"
  
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

  def get_role
    self.role.name.downcase
  end
  
  def is_seeker?
    self.get_role.eql? "seeker"
  end
  
  def is_employer?
    self.get_role.eql? "employer"
  end
  
  def is_administrator?
    self.get_role.eql? "administrator"
  end
  
  def to_s
    self.first_name + ' ' + self.last_name
  end
  
  def role_symbols
    [role.name.downcase.to_sym]
  end

  def self.search(search, page)
      search.upcase
      if ActiveRecord::Base.connection.instance_variable_get(:@config)[:database].split('/').last.eql? "development.sqlite3"
        #find(:all, :conditions => ["first_name LIKE UPPER(?) OR last_name LIKE UPPER(?) OR first_name || ' ' || last_name LIKE UPPER(?) OR email LIKE UPPER(?)", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}"])
        paginate :per_page => 1, :page => page,
                 :conditions => ["first_name LIKE UPPER(?) OR last_name LIKE UPPER(?) OR first_name || ' ' || last_name LIKE UPPER(?) OR email LIKE UPPER(?)", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%"]
      else
        #find(:all, :conditions => ["first_name ILIKE UPPER(?) OR last_name ILIKE UPPER(?) OR first_name || ' ' || last_name ILIKE UPPER(?) OR email ILIKE UPPER(?)", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%"])
        paginate :per_page => 2, :page => page,
                 :conditions => ["first_name ILIKE UPPER(?) OR last_name ILIKE UPPER(?) OR first_name || ' ' || last_name ILIKE UPPER(?) OR email ILIKE UPPER(?)", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%"]
      end
  end

  def get_my_biddings
    if self.seeking.eql? "seeker"
      return Bidding.find(:all, :conditions => {:seeker_id => self.id, :interested => nil})
    else
      return Bidding.find(:all, :conditions => {:employer_id => self.id, :interested => nil})
    end
  end
  
  def get_my_interested_biddings
    if self.seeking.eql? "seeker"
      return Bidding.find(:all, :conditions => {:seeker_id => self.id, :interested => 1})
    else
      return Bidding.find(:all, :conditions => {:employer_id => self.id, :interested => 1})
    end
  end

  def get_my_uninterested_biddings
    if self.seeking.eql? "seeker"
      return Bidding.find(:all, :conditions => {:seeker_id => self.id, :interested => 0})
    else
      return Bidding.find(:all, :conditions => {:employer_id => self.id, :interested => 0})
    end
  end

  def get_unreplied_biddings_count
    Bidding.count(:conditions => {:seeker_id => self.id, :interested => nil})
  end

  def get_interested_biddings_count
    Bidding.count(:conditions => {:seeker_id => self.id, :interested => 1})
  end

  def get_uninterested_biddings_count
    Bidding.count(:conditions => {:seeker_id => self.id, :interested => 0})
  end

  def get_tag_count
    Tag.count(:conditions => {:user_id => self.id})
  end

  def get_bid_count
    Bidding.count(:conditions => {:seeker_id => self.id})
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
  
  def add_company(company_id)
    self.company_id = company_id
    self.save
  end
  
  def belongs_to_company?
    !self.company_id.eql? nil
  end

  def has_resume?
    !self.resume_file_name.eql? nil
  end
  
  def has_bid_from_employer?(user)
    Bidding.find(:all, :conditions => {:seeker_id => self.id, :employer_id => user.id}).count > 0
  end

  def self.has_user_url?
    !self.user_url.eql? nil
  end

  protected
  
    def remove_non_digits_in_phone
      self.contact_phone.gsub!(/\D/, "") unless self.contact_phone.blank?
    end

    def assign_role
      self.role = Role.find_by_name(self.seeking) if role.nil?
    end
  
    def assign_default_url
      self.user_url = rand(2**256).to_s(36)[0..15]
    end
end
