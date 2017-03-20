require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  let (:my_user) { create(:user) }
  let (:my_list) { create(:list, user: my_user) }
  let(:my_wish) { create(:wish, list: my_list, user: my_user) }

  describe "GET #show" do
    before do
      sign_in my_user
    end

    it "returns http success" do
      get :show, id: my_user.id
      expect(response).to have_http_status(:success)
    end
  end

end
