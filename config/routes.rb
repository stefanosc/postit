PostitTemplate::Application.routes.draw do
  root to: 'posts#index'
  resources :posts, except: [:destroy] do
    resources :comments, except: [:destroy, :update, :edit]
  end

  resources :category, except: [:destroy]

end
