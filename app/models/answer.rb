class Answer < ApplicationRecord
  validates :content, {presence: true, length: {maximum: 5000}}
end
