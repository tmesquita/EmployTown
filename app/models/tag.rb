class Tag < ActiveRecord::Base
  belongs_to :user
  
  def to_s
    self.tag.titleize + ", "
  end

  def self.search(search)
      search.upcase
      find(:all, :conditions => ['tag LIKE UPPER(?)', "%#{search}%"])
  end
end
