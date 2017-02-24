require 'rails_helper'

RSpec.describe Wish, type: :model do
  let(:wish) { Wish.create!(title: "New Wish Title", body: "New Wish Body") }
    describe "attributes" do
      it "has title and body attributes" do
        expect(wish).to have_attributes(title: "New Wish Title", body: "New Wish Body")
      end
  end
end
