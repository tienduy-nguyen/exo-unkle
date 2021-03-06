Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  default_url_options :host => "http://localhost:4120/"
  namespace :api, defaults: { format: :json } do
    get "/auth/me", to: "users#me", as: "me"

    resources :users
    resources :contracts
    resources :options

    resources :users do
      resources :contracts, only: [:index]
    end
    resources :options do
      resources :contracts, only: [:index]
    end
    resources :contracts do
      resources :options, only: [:index]
      resources :users, only: [:index]
    end
  end

  devise_for :users,
             defaults: { format: :json },
             path: "",
             path_names: {
               sign_in: "api/auth/login",
               sign_out: "api/auth/logout",
               registration: "api/auth/register",
             },
             controllers: {
               sessions: "sessions",
               registrations: "registrations",
             }
end
