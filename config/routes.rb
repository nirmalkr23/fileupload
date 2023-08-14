Rails.application.routes.draw do
  get 'search', to: 'search#index', as: :search
  

  get 'p/:id', to: 'profile#show', as: :profile_show
  post 'profile/follow', to: 'profile#follow'
  delete 'profile/unfollow', to: 'profile#unfollow'
  get 'profile/followers', to: 'profile#followers'
  get 'profile/following', to: 'profile#following'


  
  get 'users_list/index'
  
  resources :comments
  devise_for :users, controllers: { 
    omniauth_callbacks: 'users/omniauth_callbacks',
    
    }

  resources :posts do
  member do
    post :update_view_count
    get :mypost
    get :test
  end
end

  resources :likes, only: [:create, :destroy]

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'posts#get_post_of_follower'
end