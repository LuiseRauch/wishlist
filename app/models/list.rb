class List < ApplicationRecord
  include Searchable

  belongs_to :user
  has_many :wishes, dependent: :destroy

  default_scope { order('created_at DESC') }

  validates :name, length: { minimum: 1, maximum: 100 }, presence: true
  validates :user, presence: true

  extend FriendlyId
  friendly_id :name, use: [:slugged, :history]

  def as_indexed_json(options={})
    self.as_json( only: [ :name ] )
  end

end
