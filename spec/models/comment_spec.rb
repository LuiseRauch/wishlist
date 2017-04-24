require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { create(:user) }
  let(:list) { create(:list, user: user) }
  let(:wish) { create(:wish, user: user, list: list) }
  let(:comment) { create(:comment, wish: wish) }

  describe "attributes" do
    it "has a body attribute" do
      expect(comment).to have_attributes(body: comment.body)
    end
  end
end
