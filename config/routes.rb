Rails.application.routes.draw do
  post "searches", to: "searches#create"
  get "autocomplete", to: "searches#autocomplete"

  resources :users, only: [:show]

  resources :users do
    get "lists"
  end

  devise_for :users, :path => 'devise'

  resources :lists do
    resources :wishes, except: [:index]
  end

  get 'about', to: 'welcome#about'

  get 'contact', to: 'welcome#contact'

  root 'welcome#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
