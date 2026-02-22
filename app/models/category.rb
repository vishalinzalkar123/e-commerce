class Category < ApplicationRecord
  has_many :products

  belongs_to :parent, class_name: "Category", optional: true
  has_many :children, class_name: "Category", foreign_key: "parent_id", dependent: :destroy

  validates :name, presence: true, uniqueness: true
end
