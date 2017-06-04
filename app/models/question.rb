class Question < ApplicationRecord
  belongs_to :survey, :inverse_of => :questions
  has_many :choices, :inverse_of => :question
  has_many :responses

  accepts_nested_attributes_for :choices,
                                :reject_if => :all_blank,
                                :allow_destroy => true
end
