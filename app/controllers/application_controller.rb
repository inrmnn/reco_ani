class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
    
     
      def after_sign_in_path_for(resource)
          case resource
          # 管理者　管理者投稿一覧画面
          when Admin
              admin_root_path
          # ユーザー　投稿一覧画面
          when User
              posts_path
          end
      end
      protected
    
      def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
      end
    
     
end
