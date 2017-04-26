class Wish < ApplicationRecord
  belongs_to :list
  belongs_to :user
  has_many :comments, dependent: :destroy

  default_scope { order('created_at DESC') }

  validates :title, length: { minimum: 5 }, presence: true
  validates :body, length: { minimum: 20 }, presence: true
  validates :url, format: { with: URI::regexp(%w(http https))}, presence: true
  validates :price, format: { with: /\A\d+(?:\.\d{0,2})?\z/ }, numericality: { greater_than: 0, less_than: 1000000 }
  validates :list, presence: true
  validates :user, presence: true
end
