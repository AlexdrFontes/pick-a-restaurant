Rails.application.routes.draw do

  root to: 'pages#home'

  get 'places/show'

  get 'places/search'

  get 'places/results', to: 'places#results'

  get 'places/my_places'  , to: 'places#my_places', as: 'places_my_places'

  get 'places/:id/saved', to: 'places#save_id', as: 'places_save_id'

  get 'places/:id', to: 'places#show_id', as: 'places_show_id'

  get "/404", :to => "errors#not_found", as: 'error_404',:via => :all

  get "/500", :to => "errors#internal_server_error", as: 'error_500', :via => :all



  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :places do
    resources :cuisine_types, :meal_types
  end
end
