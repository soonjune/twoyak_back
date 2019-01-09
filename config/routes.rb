Rails.application.routes.draw do
  namespace :user do
    resources :mypage
  end
  scope :api, defaults: { format: :json } do
    devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations', omniauth_callbacks: 'users/omniauth_callbacks', confirmations: 'users/confirmations' },
                       path_names: { sign_in: :login }
    resources :user, only: [:show, :update] do
      resources :user_infos
    end
  end

  root :to => redirect("http://twoyak.com/")

  resources :drugs, :except => :show
  get "drugs/:search_term" => "drugs#show"
  resources :drug_imprints
  get 'analysis/interaction'
  resources :search_terms
  resources :supplements, :except => :show
  get "supplements/:search_term" => "supplements#show"
  # resources :supplement_ingrs_supplements
  resources :supplement_ingrs, :except => :show
  get "supplement_ingrs/:search_term" => "supplement_ingrs#show"
  resources :interactions
  resources :dur_ingrs, :except => :show
  get "dur_ingrs/:search_term" => "dur_ingrs#show"
  # resources :drugs_dur_ingrs
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
