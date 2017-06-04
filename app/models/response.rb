class Response < ApplicationRecord
  belongs_to :question, inverse_of: :responses
  has_many :choices, :through => :question
end
