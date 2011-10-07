class User < ActiveRecord::Base
  authenticates_with_sorcery!
  
  attr_accessible :email, :password, :password_confirmation, :role_id, :first_name, :last_name, :seeking, :user_url
  
  #validates_confirmation_of :password
  #validates_presence_of :password, :on => :create
  #validates_presence_of :email
  #validates_uniqueness_of :email
  validates :password, :confirmation => true, :presence => true, :on => :create
  validates :email, :presence => true, :uniqueness => true
  
  belongs_to :role
  
  default_scope :include => :role
  
  before_create :assign_role
  
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
  
  protected
  
  def assign_role
    # This needs to change. Using 'Seeker' as default
    self.role = Role.find_by_name(self.seeking) if role.nil?
  end
end
