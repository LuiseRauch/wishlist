Rails.application.routes.draw do

  resources :users, only: [:show]

  devise_for :users, :path => 'devise'

  resources :lists do
    resources :wishes, except: [:index]
  end

  get 'about' => 'welcome#about'

  get 'contact' => 'welcome#contact'

  root 'welcome#index'

  namespace :api do
    namespace :v1 do
      resources :lists, only: [:index]
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
