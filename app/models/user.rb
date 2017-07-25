class User < ApplicationRecord
  include Searchable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessor :login

  has_many :wishes, dependent: :destroy
  has_many :lists, dependent: :destroy
  has_many :passive_relationships, class_name:  "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  validates :username, length: { minimum: 1, maximum: 100 }, presence: true
  validates :email,
          presence: true,
          uniqueness: { case_sensitive: false },
          length: { minimum: 3, maximum: 254 }

  def full_name
    "#{first_name} #{last_name}"
  end

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      if conditions[:username].nil?
        where(conditions).first
      else
        where(username: conditions[:username]).first
      end
    end
  end

  # extend FriendlyId
  # friendly_id :username, use: [:slugged, :history]

  # Returns true if the current user is following the other user.
  def following?(other_user)
    following.include?(other_user)
  end
  # Follows a user.
  def follow!(other_user)
    following << other_user
  end
  # Unfollows a user.
  def unfollow!(other_user)
    following.delete(other_user)
  end


  def as_indexed_json(options={})
    self.as_json( only: [ :username, :email, :first_name, :last_name, :city ], methods: :full_name )
  end
end
