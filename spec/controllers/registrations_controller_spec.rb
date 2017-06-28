require 'rails_helper'

RSpec.describe Devise::RegistrationsController, type: :controller do
   let (:new_user_attributes) do
    {
        username: "BlocHead",
        email: "blochead@bloc.io",
        password: "blochead",
        password_confirmation: "blochead"
    }
  end

  describe "GET new" do
    before do
      @request.env["devise.mapping"] = Devise.mappings[:user]
    end

    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
    it "instantiates a new user" do
      get :new
      expect(:new_user_attributes).to_not be_nil
    end
  end

  describe "POST create" do
    before do
      @request.env["devise.mapping"] = Devise.mappings[:user]
    end

    it "returns a http redirect" do
      post :create, user: new_user_attributes
      expect(response).to have_http_status(:redirect)
    end
    it "creates a new user" do
      expect{post :create, user: new_user_attributes}.to change(User, :count).by(1)
    end
    it "sets user name properly" do
      post :create, user: new_user_attributes
      expect(assigns(:user).username).to eq new_user_attributes[:username]
    end
    it "sets user email properly" do
      post :create, user: new_user_attributes
      expect(assigns(:user).email).to eq new_user_attributes[:email]
    end
    it "sets user password properly" do
      post :create, user: new_user_attributes
      expect(assigns(:user).password).to eq new_user_attributes[:password]
    end
    it "sets user password_confirmation properly" do
      post :create, user: new_user_attributes
      expect(assigns(:user).password_confirmation).to eq new_user_attributes[:password_confirmation]
    end
    it 'fails to sign up with an invalid email' do
      expect{User.create!(username: "Bloccit User", email: "invalid_format", password: "password", password_confirmation: "password" )}.to raise_error(ActiveRecord::RecordInvalid)
      invalid_attributes = new_user_attributes
      invalid_attributes[:email] = "invalid_format"
      expect{post :create, user: invalid_attributes}.to change(User, :count).by(0)
    end
    it 'fails to sign up with a duplicate email' do
      user = User.create!(username: "Bloccit User", email: "user@bloccit.com", password: "password", password_confirmation: "password")
      duplicate_attributes = new_user_attributes
      duplicate_attributes[:email] = user.email
      # expect(response).to have_http_status(:redirect)
      expect{post :create, user: duplicate_attributes}.to change(User, :count).by(0)
    end
  end

  # describe "not signed in" do
  #   let(:factory_user) { create(:user) }
  #
  #   before do
  #     @request.env["devise.mapping"] = Devise.mappings[:user]
  #     post :create, user: new_user_attributes
  #   end
  #
  #   it "returns http success" do
  #     get :new, {id: factory_user.id}
  #     expect(response).to have_http_status(:success)
  #   end
  #   it "renders the #new view" do
  #     get :new, {id: factory_user.id}
  #     expect(response).to render_template :new
  #   end
  # end
end
