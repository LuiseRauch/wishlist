class UsersController < ApplicationController
  def index
    @user = current_user
    @user_lists = @user.lists
    # @user_wishes = @user.wishes.order(:list_id)
    # @user_wishes_lists = @user_wishes.group_by(&:list)
  end

  def show
    @user = User.friendly.find(params[:id])
    @user_lists = @user.lists
    @user_public_lists = @user_lists.where(public: true)
  end
end
