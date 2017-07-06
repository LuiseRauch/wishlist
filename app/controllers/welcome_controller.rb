class WelcomeController < ApplicationController
  def index
    @public_lists = List.where(public: true)
    if user_signed_in?
      redirect_to lists_path
    end
  end

  def about
  end

  def contact
  end
end
