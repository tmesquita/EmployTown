class Tag < ActiveRecord::Base
  belongs_to :user
  
  def to_s
    self.tag.titleize + ", "
  end

  def self.search(search)
    
    ##################################################################
    # In progress
    search_string = "tag LIKE UPPER(\"#{search.upcase}\")"
    search = search.split(" ")
    if search.length > 1
      search_string += " OR "
      i = 1
      search.each do |item|
      if search.length.eql? i
      search_string += "tag LIKE UPPER(\"#{item.upcase}\")"
      else
      search_string += "tag LIKE UPPER(\"#{item.upcase}\") OR "
      end
      i += 1
      end
    end
    ##################################################################

    if ActiveRecord::Base.connection.instance_variable_get(:@config)[:database].split('/').last.eql? "development.sqlite3"
      find(:all, :conditions => ['tag LIKE UPPER(?)', "%#{search}"])
    else
      find(:all, :conditions => ['tag ILIKE UPPER(?)', "%#{search}%"])
    end
  end
  
  protected
    def remove_duplicates(tags)

    end
end
