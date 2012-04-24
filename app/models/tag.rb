class Tag < ActiveRecord::Base
  belongs_to :user
  
  def to_s
    self.tag.titleize + ", "
  end

  def self.search(search, page)
    #search.upcase
    if ActiveRecord::Base.connection.instance_variable_get(:@config)[:database].split('/').last.eql? "development.sqlite3"
      #find(:all, :conditions => ['tag LIKE UPPER(?)', "%#{search}"])
      paginate :per_page => 1, :page => page,
               :select => 'DISTINCT user_id',
               :conditions => ['tag LIKE UPPER(?)', "%#{search}%"]
    else
      #find(:all, :conditions => ['tag ILIKE UPPER(?)', "%#{search}%"])
      paginate :per_page => 2, :page => page,
               :conditions => ['tag ILIKE UPPER(?)', "%#{search}%"]
    end
  end
  
  protected
    def remove_duplicates(tags)

    end
end
