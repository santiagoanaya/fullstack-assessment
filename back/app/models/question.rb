class Question < ApplicationRecord
  belongs_to :survey
  has_many :answers, dependent :destroy
  # accepts_nested_attributes_for :questions, allow_destroy: true

  enum type: [ :single_choice: 0, :multiple_choice: 1, free_choice: 2 ]

  # self.abstract_class = true

  validates :title, presence: true

  # def self.question_type_select
end
