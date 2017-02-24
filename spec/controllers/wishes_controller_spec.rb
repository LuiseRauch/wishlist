require 'rails_helper'

RSpec.describe WishesController, type: :controller do
  let(:my_wish) { Wish.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph) }

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

  describe "GET edit" do
    it "returns http success" do
      get :edit, {id: my_wish.id}
      expect(response).to have_http_status(:success)
    end

    it "renders the #edit view" do
      get :edit, {id: my_wish.id}
      expect(response).to render_template :edit
    end

    it "assigns wish to be updated to @wish" do
      get :edit, {id: my_wish.id}

      wish_instance = assigns(:wish)

      expect(wish_instance.id).to eq my_wish.id
      expect(wish_instance.title).to eq my_wish.title
      expect(wish_instance.body).to eq my_wish.body
    end
  end

  describe "PUT update" do
    it "updates wish with expected attributes" do
      new_title = RandomData.random_sentence
      new_body = RandomData.random_paragraph

      put :update, id: my_wish.id, wish: {title: new_title, body: new_body}

      updated_wish = assigns(:wish)
      expect(updated_wish.id).to eq my_wish.id
      expect(updated_wish.title).to eq new_title
      expect(updated_wish.body).to eq new_body
    end

    it "redirects to the updated wish" do
      new_title = RandomData.random_sentence
      new_body = RandomData.random_paragraph

      put :update, id: my_wish.id, wish: {title: new_title, body: new_body}
      expect(response).to redirect_to my_wish
    end
  end

  describe "DELETE destroy" do
    it "deletes the wish" do
      delete :destroy, {id: my_wish.id}
      count = Wish.where({id: my_wish.id}).size
      expect(count).to eq 0
    end
  end

end
