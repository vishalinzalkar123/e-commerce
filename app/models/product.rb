class Product < ApplicationRecord
  belongs_to :category

  has_many :reviews, dependent: :destroy
  has_many :product_images, as: :imageable, dependent: :destroy

  validates :name, :price, :stock, presence: true

  scope :available, -> { where("stock > 0") }
  scope :min_price, ->(price) { where("price >= ?", price) }
  scope :max_price, ->(price) { where("price <= ?", price) }
end 
