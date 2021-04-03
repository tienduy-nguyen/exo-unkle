Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  default_url_options :host => "http://localhost:4120/"
  namespace :api, defaults: { format: :json } do
    resources :users
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
