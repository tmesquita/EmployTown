class Role < ActiveRecord::Base
  attr_accessible :name, :description, :users_count
  
  validates_length_of :name, :minimum => 1
  validates_uniqueness_of :name
  
  has_many :users
  before_create :downcase_name
  
  def to_s
    name
  end

  def self.job_seeker
    where(:name => 'job_seeker').first
  end

  def self.employer
    where(:name => 'employer').first
  end

  def self.administrator
    where(:name => 'administrator').first
  end

  private

    def downcase_name
      self.name = self.name.downcase.strip
    end
end
