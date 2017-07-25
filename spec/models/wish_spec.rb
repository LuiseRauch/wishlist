require 'rails_helper'
require "money-rails/test_helpers"
include RandomData
include MoneyRails::TestHelpers

RSpec.describe Wish, type: :model do
  let(:user) { create(:user) }
  let(:list) { create(:list, user: user) }
  let(:wish) { create(:wish, user: user, list: list) }

  it { is_expected.to belong_to(:list) }
  it { is_expected.to belong_to(:user) }

  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:body) }
  it { is_expected.to validate_presence_of(:list) }

  it { is_expected.to validate_presence_of(:list) }
  it { is_expected.to validate_presence_of(:user) }

  it { is_expected.to validate_length_of(:title).is_at_least(5) }
  it { is_expected.to validate_length_of(:body).is_at_least(20) }
  it { should allow_value("http://example.com").for(:url) }
  it { should_not allow_value("example.com").for(:url) }

  describe "attributes" do
    it "has title, body, url, price and rating attributes" do
      expect(wish).to have_attributes(title: wish.title, body: wish.body, url: wish.url, price: wish.price, rating: wish.rating)
    end
  end

  describe "money" do
    it { is_expected.to monetize(:price_cents) }
  end
end
