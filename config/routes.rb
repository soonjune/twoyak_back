Rails.application.routes.draw do
  resources :supplements
  resources :supplement_ingrs_supplements
  resources :supplement_ingrs
  resources :interactions
  resources :dur_ingrs
  resources :drugs_dur_ingrs
  resources :drugs
  resources :diseases
  resources :classifications
  get 'search/single' => 'autocomplete#search'
  get 'singleSearch/:id' => 'drugs#find_each_drug'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
