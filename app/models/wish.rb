class Wish < ApplicationRecord
  belongs_to :list
  belongs_to :user
  has_many :comments, dependent: :destroy
  accepts_nested_attributes_for :list, allow_destroy: true

  default_scope { order('created_at DESC') }

  validates :title, length: { minimum: 5 }, presence: true
  validates :body, length: { minimum: 20 }, presence: true
  validates :url, format: { with: URI::regexp(%w(http https))}, allow_blank: true
  validates :price_cents, format: { with: /\A\d+(?:\.\d{0,2})?\z/ }, numericality: { greater_than: 0, less_than: 1000000 }, allow_blank: true
  validates_inclusion_of :rating, in: 1..5, allow_blank: true
  validates :list, presence: true
  validates :user, presence: true

  monetize :price_cents, with_model_currency: :currency

  def self.all_currencies(hash)
     hash.keys
   end

  extend FriendlyId
  friendly_id :title, use: [:slugged, :history]
end
