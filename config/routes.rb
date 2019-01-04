Rails.application.routes.draw do
  scope :api, defaults: { format: :json } do
    devise_for :users, controllers: { sessions: :sessions, omniauth_callbacks: :omniauth_callbacks, confirmations: :confirmations },
                       path_names: { sign_in: :login }
    resource :user, only: [:show, :update]
  end

  root :to => redirect("http://twoyak.com/")

  resources :drugs
  resources :drug_imprints
  get 'analysis/interaction'
  resources :search_terms
  resources :supplements
  resources :supplement_ingrs_supplements
  resources :supplement_ingrs
  resources :interactions
  resources :dur_ingrs
  resources :drugs_dur_ingrs
  resources :drugs
  resources :diseases
  resources :classifications
  get 'search_terms' => 'search_terms#index'
  get 'singleSearch/' => 'drugs#find_each_drug'
  get '/multiSearch' => "analysis#interaction"
  #jwt authentication
  post 'auth_user' => 'authentication#authenticate_user'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #social login
  match 'finish_signup' => 'users#finish_signup', via: [:get, :patch], :as => :finish_signup
end
