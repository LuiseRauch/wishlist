class WelcomeController < ApplicationController
  def index
    if user_signed_in?
      redirect_to lists_path
    end
    @public_lists = List.where(public: true)
  end

  def about
  end

  def contact
  end
end
