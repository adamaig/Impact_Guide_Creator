GoogleAuthExample::Application.routes.draw do
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'
  
  #match '/new', to: 'impact_guides#template', via: 'get'
  #match '/create_guide',  to: 'impact_guides#fillout', via: 'get'

  resources :sessions, only: [:create, :destroy]
  resource :home, only: [:show]
  resources :impact_guides
  
  root to: "home#show"
end
