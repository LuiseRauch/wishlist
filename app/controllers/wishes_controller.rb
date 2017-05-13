require 'json'

class WishesController < ApplicationController
  def show
    @wish = Wish.friendly.find(params[:id])
  end

  def new
    @list = List.friendly.find(params[:list_id])
    @wish = Wish.new
    authorize @wish
  end

  def create
    @wish = Wish.new
    @wish.assign_attributes(wish_params)
    @list = List.friendly.find(params[:list_id])
    @wish.user = current_user
    @wish.list = @list
    authorize @wish

    if @wish.save
     flash[:notice] = "Wish was saved successfully."
     redirect_to @wish.list
    else
     flash.now[:alert] = "There was an error saving the wish. Please try again."
     render :new
    end
  end

  def edit
    @wish = Wish.friendly.find(params[:id])
    authorize @wish
  end

  def update
    @list = List.friendly.find(params[:list_id])
    @wish = Wish.friendly.find(params[:id])
    @wish.assign_attributes(wish_params)
    authorize @wish

    if @wish.save
      flash[:notice] = "Wish was updated successfully."
      redirect_to @wish.list
    else
      flash.now[:alert] = "There was an error saving the wish. Please try again."
      render :edit
    end
  end

  def destroy
    @wish = Wish.friendly.find(params[:id])
    authorize @wish

    if @wish.destroy
      flash[:notice] = "\"#{@wish.title}\" was deleted successfully."
      redirect_to @wish.list
    else
      flash.now[:alert] = "There was an error deleting the wish."
      render :show
    end
  end

  private

  def wish_params
    params.require(:wish).permit(:title, :body, :url, :price)
  end

end
