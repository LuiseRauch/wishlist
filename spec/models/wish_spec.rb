require 'rails_helper'
include RandomData

RSpec.describe Wish, type: :model do
  let(:user) { create(:user) }
  let(:list) { create(:list, user: user) }
  let(:wish) { create(:wish, user: user, list: list) }

  it { is_expected.to belong_to(:list) }
  it { is_expected.to belong_to(:user) }

  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:body) }
  it { is_expected.to validate_presence_of(:list) }
  it { is_expected.to validate_presence_of(:user) }

  it { is_expected.to validate_length_of(:title).is_at_least(5) }
  it { is_expected.to validate_length_of(:body).is_at_least(20) }

  describe "attributes" do
    it "has title and body attributes" do
      expect(wish).to have_attributes(title: wish.title, body: wish.body)
    end
  end
end