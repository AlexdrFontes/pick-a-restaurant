Rails.application.routes.draw do
  get 'places/show'

  get 'places/search'

  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
