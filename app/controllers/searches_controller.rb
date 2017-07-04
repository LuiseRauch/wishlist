class SearchesController < ApplicationController

  def create
  end

  def autocomplete
    @results = Autocompleter.call(params[:query])
  end
end
