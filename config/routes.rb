Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    get "/:locale" => "pages#home"
    root to: "pages#home"

    get "about", to: "pages#about"
    resources :partners, only: %i[index]
    resources :projects, only: %i[index show]
    resources :messages, only: %i[new create]
  end

  namespace :admin do
    root to: "projects#index"

    resources :pages, only: %i[index edit] do
      resources :text_block, only: [] do
        member do
          patch :update_text_block, controller: "pages"
        end
      end
    end
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
        resources :content_blocks, only: [] do
          resources :text_blocks, only: %i[create update destroy]
          resources :image_blocks, only: %i[create update destroy]
          member do
            get :update_position
          end
        end
      end
    end
    resources :team_members, only: %i[index new create edit update destroy]
    resources :partners, only: %i[index new create edit update destroy]
    resources :messages, only: %i[index show destroy]
    resources :users, only: %i[index]
  end
end
