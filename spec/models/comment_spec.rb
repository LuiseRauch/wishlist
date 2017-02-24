require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:wish) { Wish.create!(title: "New Wish Title", body: "New Wish Body") }
  let(:comment) { Comment.create!(body: 'Comment Body', wish: wish) }

  describe "attributes" do
    it "has a body attribute" do
      expect(comment).to have_attributes(body: "Comment Body")
    end
  end
end
