class Product < ActiveRecord::Base
  belongs_to :user
  has_many :line_items


  validates :title, :description, :image_url, presence: true
  validates :price, numericality: {greater_than_or_equal_to: 0.01}
  validates :title, uniqueness: true
  validates :image_url, allow_blank: true, format: {
      with:    %r{\.(gif|jpg|png)\Z}i,
      message: 'must be a URL for GIF, JPG or PNG image.'
  }
  validates :title, length: {minimum: 10}

  #@REFERENCE LaptopShop Tutorial 1
  def self.search(search_query)
    if search_query
      find(:all,:conditions => ['name LIKE ?', "%#{ search_query}%"])
    else
      find(:all)
    end
  end
end
