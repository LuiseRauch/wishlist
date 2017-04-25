require 'rails_helper'

RSpec.describe ListsController, type: :controller do
  let (:my_user) { create(:user) }
  let (:my_list) { create(:list, user: my_user) }

  context "logged in user doing CRUD on a list they own" do
    before do
      sign_in my_user
    end

    describe "GET index" do
      it "returns http success" do
        get :index
        expect(response).to have_http_status(:success)
      end
      it "assigns my_list to @list" do
        get :index
        expect(assigns(:lists)).to eq([my_list])
      end
    end

    describe "GET show" do
      it "returns http success" do
        get :show, params: {id: my_list.id}
        expect(response).to have_http_status(:success)
      end
      it "renders the #show view" do
        get :show, params: {id: my_list.id}
        expect(response).to render_template :show
      end
      it "assigns my_list to @list" do
        get :show, params: {id: my_list.id}
        expect(assigns(:list)).to eq(my_list)
      end
    end

    describe "GET new" do
      it "returns http success" do
        get :new
        expect(response).to have_http_status(:success)
      end
      it "renders the #new view" do
        get :new
        expect(response).to render_template :new
      end
      it "initializes @list" do
        get :new
        expect(assigns(:list)).not_to be_nil
      end
    end

    describe "POST create" do
      it "increases the number of lists by 1" do
        expect{ post :create, list: {name: RandomData.random_sentence, description: RandomData.random_paragraph}}.to change(List,:count).by(1)
      end
      it "assigns List.last to @list" do
        post :create, {list: {name: RandomData.random_sentence, description: RandomData.random_paragraph}}
        expect(assigns(:list)).to eq List.last
      end
      it "redirects to the new list" do
        post :create, {list: {name: RandomData.random_sentence, description: RandomData.random_paragraph}}
        expect(response).to redirect_to List.last
      end
    end

    describe "GET edit" do
      it "returns http success" do
        get :edit, {id: my_list.id}
        expect(response).to have_http_status(:success)
      end
      it "renders the #edit view" do
        get :edit, {id: my_list.id}
        expect(response).to render_template :edit
      end
      it "assigns list to be updated to @list" do
        get :edit, {id: my_list.id}
        list_instance = assigns(:list)

        expect(list_instance.id).to eq my_list.id
        expect(list_instance.name).to eq my_list.name
        expect(list_instance.description).to eq my_list.description
      end
    end

    describe "PUT update" do
      it "updates list with expected attributes" do
        new_name = RandomData.random_sentence
        new_description = RandomData.random_paragraph

        put :update, id: my_list.id, list: { name: new_name, description: new_description }

        updated_list = assigns(:list)
        expect(updated_list.id).to eq my_list.id
        expect(updated_list.name).to eq new_name
        expect(updated_list.description).to eq new_description
      end

      it "redirects to the updated list" do
        new_name = RandomData.random_sentence
        new_description = RandomData.random_paragraph

        put :update, id: my_list.id, list: { name: new_name, description: new_description }
        expect(response).to redirect_to my_list
      end
    end

    describe "DELETE destroy" do
      it "deletes the list" do
        delete :destroy, {id: my_list.id}
        count = List.where({id: my_list.id}).size
        expect(count).to eq 0
      end

      it "redirects to lists index" do
        delete :destroy, {id: my_list.id}
        expect(response).to redirect_to lists_path
      end
    end
  end
end
