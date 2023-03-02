class Post < ApplicationRecord
    belongs_to :user
    belongs_to :genre
    has_many :comments, dependent: :destroy
    has_many :favorites, dependent: :destroy
    
    default_scope -> { order(updated_at: :desc) }
    
    validates_presence_of :title, :body
    
    def favorited_by?(user)
       favorites.where(user_id: user.id).exists?
    end
end
