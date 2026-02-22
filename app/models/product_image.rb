class ProductImage < ApplicationRecord
  belongs_to :imageable, polymorphic: true
end
