class Tag < ActiveRecord::Base
  belongs_to :user

  validates :name, :presence => true

  attr_accessible :name, :user

  before_save :downcase_name
  
  def to_s
    name.downcase
  end

  def self.search(search)
    if ActiveRecord::Base.connection.instance_variable_get(:@config)[:database].split('/').last.eql? "development.sqlite3"
      where('name LIKE UPPER(?)', "%#{search}%")
    else
      where('name ILIKE UPPER(?)', "%#{search}%")
    end
  end

  private

    def downcase_name
      self.name = self.name.downcase
    end
end
