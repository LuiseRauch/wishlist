class Rating < ApplicationRecord
  belongs_to :wish

  validates_inclusion_of :score, in: 0..5
end
