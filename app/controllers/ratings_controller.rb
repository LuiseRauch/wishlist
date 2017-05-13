# require 'json'
#
# class RatingsController < ApplicationController
#
#   def create
#     @wish = Wish.friendly.find(params[:wish_id])
#     @rating = wish.ratings.new(score: params[:score])
#
#     if @rating.save
#       flash[:notice] = "Rating added."
#     else
#       flash[:error] = "Rating failed."
#     end
#     redirect_to [wish.list, wish]
#   end
#
#   def update
#     @rating = Rating.find(params[:id])
#     @wish = @rating.wish
#
#     if @rating.update_attributes(score: params[:score])
#       respond_to do |format|
#         format.js
#       end
#     end
#   end
# end
