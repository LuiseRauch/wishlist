require 'rails_helper'
include RandomData

RSpec.describe User, type: :model do
  let(:user) { create(:user) }
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
end
