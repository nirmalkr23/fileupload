Rails.application.routes.draw do
  
  get 'stories/new'
  get 'stories/create'
  get 'search', to: 'search#index', as: :search
  

  get 'p/:id', to: 'profile#show', as: :profile_show
  post 'profile/follow', to: 'profile#follow'
  delete 'profile/unfollow', to: 'profile#unfollow'
  get 'user/:id', to: 'profile#followers', as: :user_followers
  get 'user/:id', to: 'profile#following', as: :user_following


  
  get 'users_list/index'

  # room routes
  resources :rooms do
    resources :messages
  end

  # comment routes
  resources :comments

   # devise user routes
  devise_for :users, controllers: { 
    omniauth_callbacks: 'users/omniauth_callbacks',
    
    }

  get 'user/:id', to: 'users#show', as: 'user'
  resources :posts do
  member do
    post :update_view_count
    get :mypost
    get :test
  end

end

  resources :likes, only: [:create, :destroy]
  resources :stories, only: [:new, :create, :show, :destroy]
  #resources :messages, only: [:index, :show, :new, :create]


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  
  # Defines the root path route ("/")
  # root "articles#index"
  root 'posts#get_post_of_follower'
end
