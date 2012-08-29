class Tag < ActiveRecord::Base
  attr_accessible :name, :user

  belongs_to :user
  validates :name, :presence => true

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
