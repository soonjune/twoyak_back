Rails.application.routes.draw do
  namespace :user do
    resources :mypage

    scope ':user_info_id' do
      #가족력
      get "family_med_histories" => "family_med_histories#show"
      post "family_med_histories/:search_id" => "family_med_histories#create"
      delete "family_med_histories/:search_id" => "family_med_histories#destroy"
      #과거 병력
      get "past_diseases" => "past_diseases#show"
      post "past_diseases/:search_id" => "past_diseases#create"
      delete "past_diseases/:search_id" => "past_diseases#destroy"
      #현재 앓고있는 질환
      get "current_diseases" => "current_diseases#show"
      post "current_diseases/:search_id" => "current_diseases#create"
      delete "current_diseases/:search_id" => "current_diseases#destroy"
      delete "current_diseases/:search_id/to_past" => "current_diseases#destroy_to_past"
      #과거 복용 약물
      get "past_drugs" => "past_drugs#show"
      post "past_drugs/:search_id" => "past_drugs#create"
      delete "past_drugs/:search_id" => "past_drugs#destroy"
      #현재 복용 약물
      get "current_drugs" => "current_drugs#show"
      post "current_drugs/:search_id" => "current_drugs#create"
      delete "current_drugs/:search_id" => "current_drugs#destroy"
      delete "current_drugs/:search_id/to_past" => "current_drugs#destroy_to_past"
      #과거 복용 건강기능식품
      get "past_supplements" => "past_supplements#show"
      post "past_supplements/:search_id" => "past_supplements#create"
      delete "past_supplements/:search_id" => "past_supplements#destroy"
      #현재 복용 건강기능식품
      get "current_supplements" => "current_supplements#show"
      post "current_supplements/:search_id" => "current_supplements#create"
      delete "current_supplements/:search_id" => "current_supplements#destroy"
      delete "current_supplements/:search_id/to_past" => "current_supplements#destroy_to_past"

    end
  end
  scope :api, defaults: { format: :json } do
    devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations', omniauth_callbacks: 'users/omniauth_callbacks', confirmations: 'users/confirmations', passwords: 'users/passwords' },
                       path_names: { sign_in: :login }
    resources :user, only: [:show, :update]
    # social login
    post 'social' => 'users/social_login#sign_in'
  end

  root :to => redirect("http://twoyak.com/")

  resources :drugs, :except => [:index]
  # get "drugs/:search_term" => "drugs#show"
  resources :drug_imprints
  get 'analysis/interaction'
  # resources :search_terms
  # 각각에 대한 autocomplete search_term 제공
  get 'autocomplete/disease' => 'autocomplete#disease'
  get 'autocomplete/drug' => 'autocomplete#drug'
  get 'autocomplete/sup' => 'autocomplete#sup'

  resources :supplements, :except => [:show, :index]
  get "supplements/:search_term" => "supplements#show"
  # resources :supplement_ingrs_supplements
  resources :supplement_ingrs, :except => [:show, :index]
  get "supplement_ingrs/:search_term" => "supplement_ingrs#show"
  resources :interactions
  resources :dur_ingrs, :except => [:show, :index]
  get "dur_ingrs/:search_term" => "dur_ingrs#show"
  # resources :drugs_dur_ingrs
  resources :diseases
  resources :classifications
  get 'search_terms' => 'search_terms#index'
  get 'singleSearch/' => 'drugs#find_each_drug'
  get '/multiSearch' => "analysis#interaction"
  # #jwt authentication
  # post 'auth_user' => 'authentication#authenticate_user'
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #social login
  match 'finish_signup' => 'users#finish_signup', via: [:get, :patch], :as => :finish_signup
  # #for generating search_terms
  # get 'autocomplete/gen' => 'autocomplete#generate'
end
