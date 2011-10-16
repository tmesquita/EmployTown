class Tag < ActiveRecord::Base
  belongs_to :user
  
  def to_s
    self.tag.titleize + ", "
  end

  def self.search(search)
      search.upcase
      if ActiveRecord::Base.connection.instance_variable_get(:@config)[:database].split('/').last.eql? "development.sqlite3"
        find(:all, :conditions => ['tag LIKE UPPER(?)', "%#{search}%"])
      else
        find(:all, :conditions => ['tag ILIKE UPPER(?)', "%#{search}%"])
      end
  end
end
