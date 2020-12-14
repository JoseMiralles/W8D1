Rails.application.routes.draw do
  resources :users, only: [:new, :create, :index, :show]

  resource :session, only: [:new,:create,:destroy]

  resources :subs, except: [:destroy] do
    resource :posts, only: [:create]
  end

  resource :posts, except: [:create]

end
