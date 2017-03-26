Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'films#index'
  resources :films do
    member do
      post :favor
      post :dislike
    end
    resources :reviews
  end
end
