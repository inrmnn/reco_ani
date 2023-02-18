Rails.application.routes.draw do
 
  devise_for :users, controllers: {
      registrations: "public/registrations",
      sessions: 'public/sessions'
    }
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
      sessions: "admin/sessions"
  }
  
  namespace :admin do
    resources :users, only: [:index, :show]
   
    resources :genres, only: [:index, :create, :edit, :update, :destroy]
   
    resources :posts, only: [:index, :show]
  
    root to: 'homes#top'
  end
  
  scope module: :public do
    resources :posts, only: [:new, :create, :index, :show]
    
    resources :users, only: [:show]
    
    get 'homes/about'
    
    root to: 'homes#top'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
