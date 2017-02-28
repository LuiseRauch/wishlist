require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:list) { List.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph) }
  let(:wish) { list.wishes.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph) }
  let(:comment) { Comment.create!(body: 'Comment Body', wish: wish) }

  describe "attributes" do
    it "has a body attribute" do
      expect(comment).to have_attributes(body: "Comment Body")
    end
  end
end
