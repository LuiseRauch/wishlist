class UsersController < ApplicationController
  def show
    @user = current_user
    @user_wishes = @user.wishes.order(:list_id)
    @user_wishes_lists = @user_wishes.group_by(&:list)
  end
end
