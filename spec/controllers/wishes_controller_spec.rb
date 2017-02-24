require 'rails_helper'

RSpec.describe WishesController, type: :controller do


  describe "GET new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it "renders the #new view" do
      get :new
      expect(response).to render_template :new
    end

    it "instantiates @wish" do
      get :new
      expect(assigns(:wish)).not_to be_nil
    end
  end

  describe "POST create" do
    it "increases the number of Wish by 1" do
      expect{post :create, wish: {title: RandomData.random_sentence, body: RandomData.random_paragraph}}.to change(Wish,:count).by(1)
    end

    it "assigns the new wish to @wish" do
      post :create, wish: {title: RandomData.random_sentence, body: RandomData.random_paragraph}
      expect(assigns(:wish)).to eq Wish.last
    end

    it "redirects to the new wish" do
      post :create, wish: {title: RandomData.random_sentence, body: RandomData.random_paragraph}
      expect(response).to redirect_to Wish.last
    end
  end

  # describe "GET show" do
  #   it "returns http success" do
  #     get :show, {id: my_wish.id}
  #     expect(response).to have_http_status(:success)
  #   end
  #   it "renders the #show view" do
  #     get :show, {id: my_wish.id}
  #     expect(response).to render_template :show
  #   end
  #
  #   it "assigns my_wish to @wish" do
  #     get :show, {id: my_wish.id}
  #     expect(assigns(:wish)).to eq(my_wish)
  #   end
  # end
end
