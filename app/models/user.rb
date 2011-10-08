class User < ActiveRecord::Base
  authenticates_with_sorcery!
  
  attr_accessible :email, :password, :password_confirmation, :role_id, :first_name, :last_name, :seeking, :user_url, :photo, :resume, :photo_content_type
  
  validates :password, :confirmation => true, :presence => true, :on => :create
  validates :email, :presence => true, :uniqueness => true
  validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/jpg', 'image/png', 'image/gif']
  validates_attachment_content_type :resume, :content_type => ['application/msword', 'application/pdf', 'application/rtf', 'text/plain']
  
  belongs_to :role
  has_many :biddings
  has_many :tags
  
  default_scope :include => :role
  
  before_create :assign_role
  
  has_attached_file :photo, 
                    :styles => { :thumb => "150x150>", :regular => "300x300>" },
                    :url => "/assets/:class/:attachment/:id/:style.:extension",
                    :path => "#{RAILS_ROOT}/public/assets/:class/:attachment/:id/:style.:extension",
                    :default_url => "/images/default_:style.jpg",
                    :storage => :s3,
                    :s3_credentials => "#{RAILS_ROOT}/config/s3.yml"
                    
  has_attached_file :resume,
                    :url => "/assets/:class/:attachment/:id/:style.:extension",
                    :path => "#{RAILS_ROOT}/public/assets/:class/:attachment/:id/:style.:extension",
                    :storage => :s3,
                    :s3_credentials => "#{RAILS_ROOT}/config/s3.yml"
  
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

  def self.search(search)
    #if search
      puts("HERE I AM")
      search.upcase
      find(:all, :conditions => ['first_name LIKE UPPER(?)', "%#{search}%"])
    #else
     # return false
    #end
  end
  
  protected
  
  def assign_role
    # This needs to change. Using 'Seeker' as default
    self.role = Role.find_by_name(self.seeking) if role.nil?
  end
end
