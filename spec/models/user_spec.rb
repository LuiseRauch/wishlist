require 'rails_helper'
include RandomData

RSpec.describe User, type: :model do
  let(:user) { build(:user) }
  # Shoulda tests for username
  it { is_expected.to validate_presence_of(:username) }
  it { is_expected.to validate_length_of(:username).is_at_least(1) }

  # Shoulda tests for email
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_uniqueness_of(:email) }
  it { is_expected.to validate_length_of(:email).is_at_least(3) }
  it { is_expected.to allow_value("user@wishlist.com").for(:email) }

  # Shoulda tests for password
  it { is_expected.to validate_presence_of(:password) }
  it { is_expected.to validate_length_of(:password).is_at_least(6) }

  describe "attributes" do
    it "should respond to email" do
      expect(user).to respond_to(:email)
    end
    it "should respond to username" do
      expect(user).to respond_to(:username)
    end
    it "should respond to relationships" do
      expect(user).to respond_to(:passive_relationships)
    end
    it "should respond to following" do
      expect(user).to respond_to(:following)
    end
    it "should respond to following?" do
      expect(user).to respond_to(:following?)
    end
    it "should respond to follow" do
      expect(user).to respond_to(:follow)
    end
  end

  describe "invalid user" do
    let(:user_with_invalid_username) { User.new(username: "", email: "user@wishlist.com") }
    let(:user_with_invalid_email) { User.new(username: "Wishlist User", email: "") }

    it "should be an invalid user due to blank name" do
      expect(user_with_invalid_username).to_not be_valid
    end

    it "should be an invalid user due to blank email" do
      expect(user_with_invalid_email).to_not be_valid
    end
  end

  let(:user) { create(:user) }
  let(:other_user) { User.create(username: "Other User", email: "newuser@example.com", password: "helloworld", password_confirmation: "helloworld") }

  describe '#following?' do
    it "expect relationship between two users to be empty" do
      expect(user.active_relationships).to be_empty
    end
  end

  describe '#follow' do
    it "creates the active relationship between two users" do
      user.follow(other_user)
      expect(user.active_relationships.first.followed_id).to eq(other_user.id)
    end

    it "creates the passive relationship between two users" do
      user.follow(other_user)
      expect(other_user.passive_relationships.first.follower_id).to eq(user.id)
    end
  end

  # describe '#unfollow' do
  #   it "destroys the active relationship between two users" do
  #     user.follow(other_user)
  #     user.unfollow(other_user)
  #     expect(user.active_relationships.find_by.followed_id).to change(Relationship, :count).by(-1)
  #   end
  # end
end
