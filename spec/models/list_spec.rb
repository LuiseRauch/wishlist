require 'rails_helper'

RSpec.describe List, type: :model do
  let(:name) { RandomData.random_sentence }
  let(:description) { RandomData.random_paragraph }
  let(:public) { true }
  let(:list) { List.create!(name: name, description: description) }

  it { is_expected.to have_many(:wishes) }

  describe "attributes" do
    it "has name, description, and public attributes" do
      expect(list).to have_attributes(name: name, description: description, public: public)
    end

    it "is public by default" do
      expect(list.public).to be(true)
    end
  end
end
