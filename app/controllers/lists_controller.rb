class ListsController < ApplicationController
  def index
    @lists = List.all
  end

  def show
    @list = List.find(params[:id])
  end

  def new
    @list = List.new
  end

  def create
    @list = List.new
    @list.name = params[:list][:name]
    @list.description = params[:list][:description]
    @list.public = params[:list][:public]
    @list.user = current_user

    if @list.save
      flash[:notice] = "Wishlist was saved successfully."
      redirect_to @list
    else
      flash.now[:alert] = "Error creating wishlist. Please try again."
      render :new
    end
  end

  def edit
    @list = List.find(params[:id])
  end

  def update
    @list = List.find(params[:id])

    @list.name = params[:list][:name]
    @list.description = params[:list][:description]
    @list.public = params[:list][:public]

    if @list.save
       flash[:notice] = "Wishlist was updated successfully."
      redirect_to @list
    else
      flash.now[:alert] = "Error saving wishlist. Please try again."
      render :edit
    end
  end

  def destroy
    @list = List.find(params[:id])

    if @list.destroy
      flash[:notice] = "\"#{@list.name}\" was deleted successfully."
      redirect_to action: :index
    else
      flash.now[:alert] = "There was an error deleting the wishlist."
      render :show
    end
  end
end
