require 'rails_helper'
include RandomData

RSpec.describe WishesController, type: :controller do
  let (:my_user) { create(:user) }
  let (:my_list) { create(:list, user: my_user) }
  let (:my_wish) { create(:wish, list: my_list, user: my_user) }


  # todo
  # context "guest" do
  # end
  
  context "logged in user doing CRUD on a wish they do NOT own" do
    before do
      other_user = User.create!(username: "Test User", email: "test@example.com", password: "helloworld", password_confirmation: "helloworld")
      sign_in other_user
    end

    describe "GET new" do
      it "returns http success" do
        get :new, list_id: my_list.id
        expect(response).to have_http_status(:success)
      end

      it "renders the #new view" do
        get :new, list_id: my_list.id
        expect(response).to render_template :new
      end

      it "instantiates @wish" do
        get :new, list_id: my_list.id
        expect(assigns(:wish)).not_to be_nil
      end
    end

    describe "POST create" do
      it "increases the number of Wish by 1" do
        expect{post :create, list_id: my_list.id, wish: {title: RandomData.random_sentence, body: RandomData.random_paragraph, url: RandomData.random_url, price: RandomData.random_number, rating: RandomData.random_rating}}.to change(Wish,:count).by(1)
      end

      it "assigns the new wish to @wish" do
        post :create, list_id: my_list.id, wish: {title: RandomData.random_sentence, body: RandomData.random_paragraph, url: RandomData.random_url, price: RandomData.random_number, rating: RandomData.random_rating}
        expect(assigns(:wish)).to eq Wish.last
      end

      it "redirects to the list" do
        post :create, list_id: my_list.id, wish: {title: RandomData.random_sentence, body: RandomData.random_paragraph, url: RandomData.random_url, price: RandomData.random_number, rating: RandomData.random_rating}
        expect(response).to redirect_to my_list
      end
    end

    describe "GET edit" do
      it "returns http redirect" do
        get :edit, list_id: my_list.id, id: my_wish.id
        expect(response).to redirect_to lists_path
      end
    end

    describe "PUT update" do
      it "returns http redirect" do
        new_title = RandomData.random_sentence
        new_body = RandomData.random_paragraph
        new_url = RandomData.random_url
        new_price = RandomData.random_number
        new_rating = RandomData.random_rating

        put :update, list_id: my_list.id, id: my_wish.id, wish: {title: new_title, body: new_body, url: new_url, price: new_price, rating: new_rating}
        expect(response).to redirect_to lists_path
      end
    end

    describe "DELETE destroy" do
      it "returns http redirect" do
        delete :destroy, list_id: my_list.id, id: my_wish.id
        expect(response).to redirect_to lists_path
      end
    end
  end

  context "logged in user doing CRUD on a wish they own" do
    before do
      sign_in my_user
    end

    describe "GET new" do
      it "returns http success" do
        get :new, list_id: my_list.id
        expect(response).to have_http_status(:success)
      end

      it "renders the #new view" do
        get :new, list_id: my_list.id
        expect(response).to render_template :new
      end

      it "instantiates @wish" do
        get :new, list_id: my_list.id
        expect(assigns(:wish)).not_to be_nil
      end
    end

    describe "POST create" do
      it "increases the number of Wish by 1" do
        expect{post :create, list_id: my_list.id, wish: {title: RandomData.random_sentence, body: RandomData.random_paragraph, url: RandomData.random_url, price: RandomData.random_number, rating: RandomData.random_rating}}.to change(Wish,:count).by(1)
      end

      it "assigns the new wish to @wish" do
        post :create, list_id: my_list.id, wish: {title: RandomData.random_sentence, body: RandomData.random_paragraph, url: RandomData.random_url, price: RandomData.random_number, rating: RandomData.random_rating}
        expect(assigns(:wish)).to eq Wish.last
      end

      it "redirects to the list" do
        post :create, list_id: my_list.id, wish: {title: RandomData.random_sentence, body: RandomData.random_paragraph, url: RandomData.random_url, price: RandomData.random_number, rating: RandomData.random_rating}
        expect(response).to redirect_to my_list
      end
    end

    describe "GET edit" do
      it "returns http success" do
        get :edit, list_id: my_list.id, id: my_wish.id
        expect(response).to have_http_status(:success)
      end

      it "renders the #edit view" do
        get :edit, list_id: my_list.id, id: my_wish.id
        expect(response).to render_template :edit
      end

      it "assigns wish to be updated to @wish" do
        get :edit, list_id: my_list.id, id: my_wish.id

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
        new_url = RandomData.random_url
        new_price = RandomData.random_number
        new_rating = RandomData.random_rating

        put :update, list_id: my_list.id, id: my_wish.id, wish: {title: new_title, body: new_body, url: new_url, price: new_price, rating: new_rating}

        updated_wish = assigns(:wish)
        expect(updated_wish.id).to eq my_wish.id
        expect(updated_wish.title).to eq new_title
        expect(updated_wish.body).to eq new_body
        expect(updated_wish.url).to eq new_url
        expect(updated_wish.price).to eq new_price
        expect(updated_wish.rating).to eq new_rating

      end

      it "redirects to the updated wish" do
        new_title = RandomData.random_sentence
        new_body = RandomData.random_paragraph
        new_url = RandomData.random_url
        new_price = RandomData.random_number
        new_rating = RandomData.random_rating

        put :update, list_id: my_list.id, id: my_wish.id, wish: {title: new_title, body: new_body, url: new_url, price: new_price, rating: new_rating}
        expect(response).to redirect_to my_list
      end
    end

    describe "DELETE destroy" do
      it "deletes the wish" do
        delete :destroy, list_id: my_list.id, id: my_wish.id
        count = Wish.where({id: my_wish.id}).size
        expect(count).to eq 0
      end
      it "redirects to list show" do
        delete :destroy, list_id: my_list.id, id: my_wish.id
        expect(response).to redirect_to my_list
      end
    end
  end
end
