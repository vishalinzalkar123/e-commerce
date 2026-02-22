class Review < ApplicationRecord
  belongs_to :user
  belongs_to :product, counter_cache: true

  validates :rating, presence: true, inclusion: { in: 1..5 }
end
