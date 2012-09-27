class Tag < ActiveRecord::Base
  attr_accessible :name, :user

  belongs_to :user
  validates :name, :presence => true

  before_save :downcase_name
  
  def to_s
    name.downcase
  end

  def self.search(search)
      where('name LIKE UPPER(?)', "%#{search}%")
  end

  private

    def downcase_name
      self.name = self.name.downcase
    end
end
