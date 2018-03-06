Rails.application.routes.draw do
  get 'places/show'

  get 'places/search'

  get 'places/results', to: 'places#results'

  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :places do
    resources :cuisine_types, :meal_types
  end
end
