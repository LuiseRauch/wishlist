class WishesController < ApplicationController
  def show
    @wish = Wish.find(params[:id])
  end

  def new
    @list = List.find(params[:list_id])
    @wish = Wish.new
  end

  def create
    @wish = Wish.new
    @wish.title = params[:wish][:title]
    @wish.body = params[:wish][:body]
    @list = List.find(params[:list_id])
    @wish.user = current_user

    @wish.list = @list

    if @wish.save
     flash[:notice] = "Wish was saved successfully."
     redirect_to [@list, @wish]
    else
     flash.now[:alert] = "There was an error saving the wish. Please try again."
     render :new
    end
  end

  def edit
    @wish = Wish.find(params[:id])
  end

  def update
    @wish = Wish.find(params[:id])
    @wish.title = params[:wish][:title]
    @wish.body = params[:wish][:body]

    if @wish.save
      flash[:notice] = "Wish was updated successfully."
      redirect_to [@wish.list, @wish]
    else
      flash.now[:alert] = "There was an error saving the wish. Please try again."
      render :edit
    end
  end

  def destroy
    @wish = Wish.find(params[:id])

    if @wish.destroy
      flash[:notice] = "\"#{@wish.title}\" was deleted successfully."
      redirect_to @wish.list
    else
      flash.now[:alert] = "There was an error deleting the wish."
      render :show
    end
  end
end
