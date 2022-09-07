class Question < ApplicationRecord
  validates :title, presence: true
  self.abstract_class = true
end
