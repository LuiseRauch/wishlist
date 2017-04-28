class List < ApplicationRecord
  belongs_to :user
  has_many :wishes, dependent: :destroy

  validates :name, length: { minimum: 1, maximum: 100 }, presence: true
  validates :user, presence: true

  extend FriendlyId
  friendly_id :name, use: [:slugged, :history]

end
