Rails.application.routes.draw do
 
  devise_for :users, controllers: {
      registrations: "public/registrations",
      sessions: 'public/sessions'
    }
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
      sessions: "admin/sessions"
  }
  
  namespace :admin do
    resources :users, only: [:index, :show, :destroy]
   
    resources :genres, only: [:index, :create, :edit, :update, :destroy]
   
    resources :posts, only: [:show, :destroy] do 
      resources :comment, only: [:destroy]
    end
    root to: 'posts#index'
    get 'posts/comments/:id' => 'posts#comments' , as: 'comments'
  
   
  end
  
  scope module: :public do
    resources :posts, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
       collection do
        get 'search'
       end
       resources :comments, only: [:create]
     end 
    get 'posts/comment/:id' => 'posts#comment' , as: 'comment'
    
    resources :users, only: [:show, :edit, :update]
    
    
    root to: 'homes#top'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
