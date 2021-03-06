GoogleAuthExample::Application.routes.draw do
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'
 
  get 'impact_guides', to: 'impact_guides#index', as:'impact_guides'
  
  
  #template', via: 'get'
  #match '/create_guide',  to: 'impact_guides#fillout', via: 'get'

  resources :sessions, only: [:create, :destroy, :show]
  resource :home, only: [:show]
  resources :impact_guides
  resources :responses, only: [:create, :destroy, :update]
  resources :users, only: [:show, :index, :edit, :update]
  resources :games, only: [:show]
  
  root to: "home#show"
end
