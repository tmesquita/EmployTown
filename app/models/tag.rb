class Tag < ActiveRecord::Base
  belongs_to :user
  
  def to_s
    self.tag.titleize + ", "
  end
end
