Rails.application.routes.draw do

  resources :users, only: [:show]

  devise_for :users, :path => 'devise'

  resources :lists do
    resources :wishes, except: [:index]
  end

  resources :wishes, only: [] do
    resources :ratings, only: [:update]
  end

  get 'about' => 'welcome#about'

  get 'contact' => 'welcome#contact'

  root 'welcome#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
