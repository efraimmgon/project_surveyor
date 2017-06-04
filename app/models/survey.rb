class Survey < ApplicationRecord
  has_many :questions, :inverse_of => :survey
  has_many :responses, :through => :questions

  accepts_nested_attributes_for :questions,
                                :reject_if => :all_blank,
                                :allow_destroy => true
end
