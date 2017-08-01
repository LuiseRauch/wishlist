class User < ApplicationRecord
  include Searchable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessor :login

  has_many :wishes, dependent: :destroy
  has_many :lists, dependent: :destroy
  has_many :active_relationships,  class_name:  "Relationship", foreign_key: "follower_id", dependent:   :destroy
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

  extend FriendlyId
  friendly_id :username, use: [:slugged, :history]

  # Follows a user.
  def follow(other_user)
    following << other_user
  end
  # Unfollows a user.
  def unfollow(other_user)
    following.delete(other_user)
  end
  # Returns true if the current user is following the other user.
  def following?(other_user)
    following.include?(other_user)
  end

  def as_indexed_json(options={})
    self.as_json( only: [ :username, :email, :first_name, :last_name, :city ], methods: :full_name )
  end

  # create a task with whenever
  # the task iterates through all users that follow at least one user
  # if there is an update from those users that are followed
  # generate email with the actual updates

  # def get_friends?(user)
  #   friends = []
  #
  #   if user.following.any?
  #     user.following.each do |friend|
  #       friends << friend
  #     end
  #   end
  #   has_updates?(friends)
  # end
  #
  # def has_updates?(friends)
  #
  #   active_public_lists = []
  #   active_wishes = []
  #
  #     friends.each do |friend|
  #       active_public_lists << friend.lists.where(public: true).where("updated_at >= ?", Time.zone.now - 24.hours)
  #     end
  #
  #     friends.each do |friend|
  #       public_wishes = friend.wishes.joins(:list).where(lists: { public: true })
  #       active_wishes <<  public_wishes.where("wishes.updated_at >= ?", Time.zone.now - 24.hours)
  #     end
  #
  #     puts active_public_lists
  #     puts active_wishes
  # end
  #
  # def send_daily_updates(active_public_lists, active_wishes)
  #
  #
  # end

  # scope :recent, -> { where("updated_at >= ?", Time.zone.now - 24.hours ) }
  # active_public_lists.recent.any? / active_wishes.recent.any?


end
