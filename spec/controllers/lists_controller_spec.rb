require 'rails_helper'
include RandomData

RSpec.describe ListsController, type: :controller do
  let (:my_user) { create(:user) }
  let (:my_list) { create(:list, user: my_user, public: true) }
  let (:my_private_list) { create(:list, user: my_user, public: false) }

  context "guest" do
    describe "GET #index" do
      it "returns http redirect" do
        get :index
        expect(response).to redirect_to(root_path)
      end
    end

    describe "GET show" do
      it "returns http success" do
        get :show, {id: my_list.id}
        expect(response).to have_http_status(:success)
      end
      it "renders the #show view" do
        get :show, {id: my_list.id}
        expect(response).to render_template :show
      end
      it "assigns my_list to @list" do
        get :show, {id: my_list.id}
        expect(assigns(:list)).to eq(my_list)
      end
    end

    describe "GET new" do
      it "returns http redirect" do
        get :new
        expect(response).to redirect_to(root_path)
      end
    end

    describe "POST create" do
      it "returns http redirect" do
        post :create, list: {name: RandomData.random_sentence, description: RandomData.random_paragraph}
        expect(response).to redirect_to(root_path)
      end
    end

    describe "GET edit" do
      it "returns http redirect" do
        get :edit, {id: my_list.id}
        expect(response).to redirect_to(root_path)
      end
    end

    describe "PUT update" do
      it "updates list with expected attributes" do
        new_name = RandomData.random_sentence
        new_description = RandomData.random_paragraph
        put :update, id: my_list.id, list: { name: new_name, description: new_description }
        expect(response).to redirect_to(root_path)
      end
    end

    describe "DELETE destroy" do
      it "returns http redirect" do
        delete :destroy, {id: my_list.id}
        expect(response).to redirect_to(root_path)
      end
    end
  end


  context "logged in user doing CRUD on a list they do NOT own" do
    before do
      other_user = User.create!(username: "Test User", email: "test@example.com", password: "helloworld", password_confirmation: "helloworld")
      sign_in other_user
    end

    describe "GET #index" do
      it "returns http success" do
        get :index
        expect(response).to have_http_status(:success)
      end
      it "assigns List.all to list" do
        get :index
        expect(assigns(:public_lists)).to eq([my_list])
      end
      it "does not include private lists in @lists" do
        get :index
        expect(assigns(:public_lists)).not_to include(my_private_list)
      end
    end

    describe "GET show" do
      it "returns http success" do
        get :show, {id: my_list.id}
        expect(response).to have_http_status(:success)
      end
      it "renders the #show view" do
        get :show, {id: my_list.id}
        expect(response).to render_template :show
      end
      it "assigns my_list to @list" do
        get :show, {id: my_list.id}
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
      it "instantiates @list" do
        get :new
        expect(assigns(:list)).not_to be_nil
      end
    end

    describe "POST create" do
      it "increases the number of List by 1" do
        expect{ post :create, list: {name: RandomData.random_sentence, description: RandomData.random_paragraph}}.to change(List,:count).by(1)
      end
      it "assigns the new list to @list" do
        post :create, {list: {name: RandomData.random_sentence, description: RandomData.random_paragraph}}
        expect(assigns(:list)).to eq List.last
      end
      it "redirects to the new list" do
        post :create, {list: {name: RandomData.random_sentence, description: RandomData.random_paragraph}}
        expect(response).to redirect_to List.last
      end
    end

    describe "GET edit" do
      it "returns http redirect" do
        get :edit, id: my_list.id
        expect(response).to redirect_to(root_path)
      end
    end

    describe "PUT update" do
      it "returns http redirect" do
        new_name = RandomData.random_sentence
        new_description = RandomData.random_paragraph

        put :update, id: my_list.id, list: { name: new_name, description: new_description }
        expect(response).to redirect_to(root_path)
      end
    end

    describe "DELETE destroy" do
      it "returns http redirect" do
        delete :destroy, id: my_list.id
        expect(response).to redirect_to(root_path)
      end
    end
  end


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
        expect(assigns(:public_lists)).to eq([my_list])
      end
      it "does not include private lists in @lists" do
        get :index
        expect(assigns(:public_lists)).not_to include(my_private_list)
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
