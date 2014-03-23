class Product < ActiveRecord::Base
  before_destroy :ensure_not_referenced_by_any_line_item
  before_destroy :ensure_not_referenced_by_any_promotion_line

  has_many :line_items
  has_many :orders, through: :line_items
  has_many :prices
  has_many :promotion_lines
  has_many :habtm_products
  has_many :product_types, through: :habtm_products

  accepts_nested_attributes_for :prices

  attr_accessible :titulo, :descripcion, :image_url, :cantidad, :type_tokens, :prices_attributes
  attr_reader :type_tokens

  validates :titulo, :descripcion, :image_url, presence: true
  validates :titulo, uniqueness: true
  validates :image_url, format: {
      with: %r{\.(gif|png|jpg)$}i,
      message: 'Debe ser una direccion de una imagen GIF, PNG o JPG.'
  }

  def type_tokens=(ids)
    self.product_type_ids = ids.split(",")
  end

  def self.last_products
    Product.last(5).reverse
  end

  def to_s
    titulo
  end

  def actual_public_price
    prices.last.public_price
  end

  def actual_cost
    prices.last.cost
  end

  def update_promotion
    promotion_lines.map(&:promotion_id).uniq.each do |id|
      promotion = Promotion.find(id)
      promotion.update_attributes total: promotion.total_price
    end
  end

  private
  def ensure_not_referenced_by_any_line_item
    unless line_items.empty?
      errors.add(:base, 'Line Items present')
      true
    end
  end

  def ensure_not_referenced_by_any_promotion_line
    unless promotion_lines.empty?
      errors.add(:base, 'Promotion Line present')
      false
    end
  end
end
