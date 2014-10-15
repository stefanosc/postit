PostitTemplate::Application.routes.draw do
  root to: 'posts#index'

  get '/register', to: 'users#new'
  get '/profile', to: 'users#show'
  get '/profile/edit', to: 'users#edit'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'


  resources :posts, except: [:destroy] do
    member do
      post :vote
      get :vote
    end

    resources :comments, only: [:create] do
      member do
        post :vote
        get :vote
      end
    end
    collection do
      get 'search'
    end
  end

  resources :categories, except: [:destroy]
  resources :users, except: [:index, :destroy, :new]


end
