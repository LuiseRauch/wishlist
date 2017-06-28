require 'rails_helper'
include RandomData

RSpec.describe List, type: :model do
  let(:user) { create(:user) }
  let(:list) { create(:list, user: user) }

  it { is_expected.to have_many(:wishes) }

  describe "attributes" do
    it "has name, description, and public attributes" do
      expect(list).to have_attributes(name: list.name, description: list.description, public: true)
    end

    it "is public by default" do
      expect(list.public).to be(true)
    end
  end
end
