Rails.application.routes.draw do
  
  
   # ユーザー用
    # URL /users/sign_in ...
  devise_for :users, controllers: {
      registrations: "public/registrations",
      sessions: 'public/sessions'
    }
    
   # 管理者用
    # URL /admin/sign_in ...  　サインインの場合はurlを打ち込んでください
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
      sessions: "admin/sessions"
  }
  
  # 管理者用(adminから始まる）
  namespace :admin do
    resources :users, only: [:index, :show, :destroy]
   
    resources :genres, only: [:index, :create, :edit, :update, :destroy]
   
    resources :posts, only: [:show, :destroy] do
      
      # posts controllerだけだと削除がうまく行かないので分けています
      resources :comments, only: [:destroy]
      
    end
    
     # 投稿一覧画面がadminルートパスです
    root to: 'posts#index'
   
    get 'posts/comments/:id' => 'posts#comments' , as: 'comments'
   
  end
  
  # ユーザー用
  scope module: :public do
    resources :posts, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
      # 検索結果表示用
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
