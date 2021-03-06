class User < ActiveRecord::Base
  authenticates_with_sorcery!

  belongs_to :role
  has_many :tags
  
  attr_accessible :email, :password, :password_confirmation, :role_id, :first_name, :last_name, :seeking, :user_url, :photo, :resume, :company_id, :about_me, :ideal_role
  attr_accessible :blog_address, :facebook, :twitter, :contact_email, :contact_phone

  before_validation :remove_non_digits_in_phone
  
  validates :email, :presence => true, :uniqueness => true
  validates :password, :confirmation => true, :presence => true, :on => :create
  validates :password, :confirmation => true, :on => :update, :unless => lambda { self.password.blank? }
  validates_presence_of :first_name, :last_name
  validates_attachment_content_type :resume, :content_type => ['application/msword', 'application/pdf', 'application/rtf', 'text/plain', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document']
  validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/jpg', 'image/png', 'image/gif']
  validates :user_url, :presence => true, :uniqueness => true, :on => :update

  default_scope :include => :role

  before_create :assign_default_url
  after_create :notify_signup
  before_save :remove_http_from_blog

  validates_format_of :contact_email,
      :message => 'must look like an email address',
      :with => /\b[a-zA-Z0-9._%-]+@[a-zA-Z0-9_.-]+\.[a-zA-Z]{2,4}\b/,
      :on => :update,
      :allow_blank => true

  validates_format_of :email,
      :message => 'must look like an email address',
      :with => /\b[a-zA-Z0-9._%-]+@[a-zA-Z0-9_.-]+\.[a-zA-Z]{2,4}\b/,
      :allow_blank => false
  
  validates_format_of :user_url,
      :message => 'can only contain numbers, letters, and underscores',
      :with => /^[\w]+$/,
      :on => :update

  validates_format_of :contact_phone,
      :message => "must be 10 digits long and only contain digits",
      :with => /^[\(\)0-9\- \+\.]{10}$/,
      :allow_blank => true

  validates_format_of :blog_address,
      :message => 'URL must look like a url',
      :with => /(http:\/\/www\.|http:\/\/|www\.)?.*\..*/,
      :allow_blank => true,
      :on => :update

  has_attached_file :photo, 
                    :styles => { :thumb => "50x50>", :small => "150x150>", :regular => "300x300>" },
                    :storage => :dropbox,
                    :dropbox_credentials => "#{Rails.root}/config/dropbox.yml",
                    :dropbox_options => {
                      path: proc { |style| "users/#{id}/#{style}/#{id}_#{photo.original_filename}"},
                      unique_filename: true
                    }
                    
  has_attached_file :resume,
                    :storage => :dropbox,
                    :dropbox_credentials => "#{Rails.root}/config/dropbox.yml",
                    :dropbox_options => {
                      path: proc { |style| "users/#{id}/resume/#{id}_#{resume.original_filename}"},
                      unique_filename: true
                    }

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

  private

    def notify_signup
      UserMailer.notify_signup(self.email).deliver
    end
end
