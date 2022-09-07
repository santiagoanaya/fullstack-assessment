class Survey < ApplicationRecord
  has_many :questions, dependent: :destroy
  # accepts_nested_attributes_for :questions, allow_destroy: true

  validates :title, presence: true
  validates :questions > 2
end
