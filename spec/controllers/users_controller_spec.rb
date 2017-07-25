require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let (:my_user) { create(:user) }
  let (:my_list) { create(:list, user: my_user) }
  let (:my_wish) { create(:wish, list: my_list, user: my_user) }

  describe "GET #show" do
    before do
      sign_in my_user
    end

    it "returns http success" do
      get :show, id: my_user.id
      expect(response).to have_http_status(:success)
    end

    it "renders the #show view" do
      get :show, id: my_user.id
      expect(response).to render_template :show
    end

    # it "renders the current_user #show view regardless of id" do
    #   get :show, id: 500
    #   expect(assigns(:user)).to eq my_user
    # end

    it "returns my_users lists" do
      my_list
      get :show, id: my_user.id
      expect(assigns(:user_lists)).to eq [my_list]
    end

    # it "returns current_user lists regardless of id" do
    #   my_list
    #   get :show, id: 500
    #   expect(assigns(:user_lists)).to eq [my_list]
    # end
  end
end
