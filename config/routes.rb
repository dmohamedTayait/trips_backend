Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1, defaults: {format: 'json'} do
      resources :sessions, only: [:create, :destroy]
      resources :trips, only: [:index, :create, :destroy] do
        patch :mark_completed 
        resources :trip_locations, only: [:create]
      end
      
    
    end
  end
end
