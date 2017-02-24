class Wish < ApplicationRecord
  has_many :comments, dependent: :destroy
end
