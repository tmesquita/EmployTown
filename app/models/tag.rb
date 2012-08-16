class Tag < ActiveRecord::Base
  belongs_to :user

  validates :tag, :presence => true

  attr_accessible :tag, :user
  
  def to_s
    self.tag.titleize + ", "
  end

  def self.search(search, page)
    if ActiveRecord::Base.connection.instance_variable_get(:@config)[:database].split('/').last.eql? "development.sqlite3"
      where('tag LIKE UPPER(?)', "%#{search}%").paginate(:per_page => 2, :page => page).select('DISTINCT user_id')
    else
      where('tag ILIKE UPPER(?)', "%#{search}%").paginate(:per_page => 2, :page => page)
    end
  end
end
