Rails.application.routes.draw do

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :topics, only: [:index, :show, :destroy] do
        member do
          resources :resources, only: [:index, :create]
        end
      end

      resources :resources, only: [] do
        member do
          put :add_tag
        end
      end
    end
  end

  root 'home#index'
end
