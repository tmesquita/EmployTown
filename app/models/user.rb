class User < ActiveRecord::Base
  authenticates_with_sorcery!
  
  attr_accessible :email, :password, :password_confirmation, :role_id
  
  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email
  validates_uniqueness_of :email
  
  belongs_to :role
  
  default_scope :include => :role
  
  before_create :assign_role
  
  def role_symbols
    [role.name.downcase.to_sym]
  end
  
  protected
  
  def assign_role
    # This needs to change. Using 'Seeker' as default
    self.role = Role.find_by_name('seeker') if role.nil?
  end
end
