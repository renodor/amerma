Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  root "home#home"

  resources :projects, only: %i[index show]

  namespace :admin do
    resources :project_categories, only: %i[index edit update] do
      member do
        get :update_position
      end
    end
    resources :projects, only: %i[index new create show edit update destroy] do
      resources :container_blocks, only: %i[create update destroy] do
        member do
          get :update_position
        end
        resources :text_blocks, only: %i[create update]
        resources :image_blocks, only: %i[create update]
        resources :content_blocks, only: :destroy do
          member do
            get :update_position
          end
        end
      end
    end
    resources :team_members, only: %i[index new create edit update destroy]
  end
end
