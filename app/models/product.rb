class Product < ActiveRecord::Base
  belongs_to :user
  has_many :line_items

  before_destroy :ensure_not_referenced_by_any_line_item

  validates :name, :description, :image_url, presence: true
  validates :price, numericality: {greater_than_or_equal_to: 0.01}
  validates :name, uniqueness: true
  validates :image_url, allow_blank: true, format: {
      with:    %r{\.(gif|jpg|png)\Z}i,
      message: 'must be a URL for GIF, JPG or PNG image.'
  }
  validates :name, length: {minimum: 10}

  #@REFERENCE LaptopShop Tutorial 1
  def self.search(search_query)
    if search_query
      find(:all,:conditions => ['name LIKE ?', "%#{ search_query}%"])
    else
      find(:all)
    end
  end

  private

  # ensure that there are no line items referencing this product
  def ensure_not_referenced_by_any_line_item
    if line_items.empty?
      return true
    else
      errors.add(:base, 'Line Items present')
      return false
    end
  end
end
