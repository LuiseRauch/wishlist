class List < ApplicationRecord
  has_many :wishes, dependent: :destroy
end
