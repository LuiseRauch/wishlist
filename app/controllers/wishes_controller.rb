class WishesController < ApplicationController
  # def show
  #   @wish = Wish.find(params[:id])
  # end

  def new
    @wish = Wish.new
  end

  def create
    @wish = Wish.new
    @wish.title = params[:wish][:title]
    @wish.body = params[:wish][:body]

    if @wish.save
     flash[:notice] = "Wish was saved successfully."
     redirect_to @wish
    else
     flash.now[:alert] = "There was an error saving the wish. Please try again."
     render :new
    end
  end

  def edit
  end
end
