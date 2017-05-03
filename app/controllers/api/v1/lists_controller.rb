class Api::V1::ListsController < ApplicationController
  respond_to :json

  def index
    lists = List.all
    render json: lists, status: 200
  end
end
