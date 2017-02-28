require 'rails_helper'

RSpec.describe Wish, type: :model do
  let(:name) { RandomData.random_sentence }
  let(:description) { RandomData.random_paragraph }
  let(:title) { RandomData.random_sentence }
  let(:body) { RandomData.random_paragraph }
  let(:list) { List.create!(name: name, description: description) }
  let(:wish) { list.wishes.create!(title: title, body: body) }

  it { is_expected.to belong_to(:list) }

  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:body) }
  it { is_expected.to validate_presence_of(:list) }

  it { is_expected.to validate_length_of(:title).is_at_least(5) }
  it { is_expected.to validate_length_of(:body).is_at_least(20) }

  describe "attributes" do
    it "has title and body attributes" do
      expect(wish).to have_attributes(title: title, body: body)
    end
  end
end
