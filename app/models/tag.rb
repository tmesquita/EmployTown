class Tag < ActiveRecord::Base
  belongs_to :user
  
  def to_s
    self.tag.titleize + ", "
  end

  def self.search(search)
    search_string = "\"#{search.upcase}\""
    search = search.split(" ")
    if search.length > 1
      search_string += " OR "
      i = 1
      search.each do |item|
      if search.length.eql? i
      search_string += "\"#{item.upcase}\""
      else
      search_string += "\"#{item.upcase}\" OR "
      end
      i += 1
      end
    end
    
    puts search_string

    if ActiveRecord::Base.connection.instance_variable_get(:@config)[:database].split('/').last.eql? "development.sqlite3"
      find(:all, :conditions => ['tag LIKE UPPER(?)', "%#{search_string}%"])
    else
      find(:all, :conditions => ['tag ILIKE UPPER(?)', "%#{search_string}%"])
    end
  end
  
  protected
    def remove_duplicates(tags)

    end
end
