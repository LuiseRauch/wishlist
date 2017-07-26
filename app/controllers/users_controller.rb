class UsersController < ApplicationController
  # def index
    # @user = current_user
    # @user_lists = @user.lists
    # @user_wishes = @user.wishes.order(:list_id)
    # @user_wishes_lists = @user_wishes.group_by(&:list)
  # end
  def show
    @user = User.find(params[:id])
    @user_lists = @user.lists
    @user_public_lists = @user_lists.where(public: true)

  end

  def public_lists
    @user = User.find(params[:id])
    @user_public_lists = @user.lists.where(public: true)
  end

  def lists
    @user = current_user
    @user_lists = @user.lists
  end

  def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end
end
