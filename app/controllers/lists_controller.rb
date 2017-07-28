require 'json'

class ListsController < ApplicationController
  def index
    @public_lists = policy_scope(List.where(public: true))
    authorize @public_lists
  end

  def show
    @list = List.friendly.find(params[:id])
  end

  def new
    @list = List.new
    authorize @list
  end

  def create
    @list = List.new
    @list.assign_attributes(list_params)
    @list.user = current_user
    authorize @list

    if @list.save
      flash[:notice] = "Wishlist was saved successfully."
      redirect_to @list
    else
      flash.now[:alert] = "Error creating wishlist. Please try again."
      render :new
    end
  end

  def edit
    @list = List.friendly.find(params[:id])
    authorize @list
  end

  def update
    @list = List.friendly.find(params[:id])
    @list.assign_attributes(list_params)
    authorize @list

    if @list.save
      flash[:notice] = "Wishlist was updated successfully."
      redirect_to @list
    else
      flash.now[:alert] = "Error saving wishlist. Please try again."
      render :edit
    end
  end

  def destroy
    @list = List.friendly.find(params[:id])
    authorize @list

    if @list.destroy
      flash[:notice] = "\"#{@list.name}\" was deleted successfully."
      redirect_to action: :index
    else
      flash.now[:alert] = "There was an error deleting the wishlist."
      render :show
    end
  end

  private

  def list_params
    params.require(:list).permit(:name, :description, :public)
  end
end
