Rails.application.routes.draw do

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :topics, only: [:index, :destroy] do
        member do
          resources :resources, only: [:index, :create]
        end
      end
    end
  end

  root 'home#index'
end
