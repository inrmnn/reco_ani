class Post < ApplicationRecord
    belongs_to :user
    belongs_to :genre
    has_many :comments, dependent: :destroy
    
    default_scope -> { order(updated_at: :desc) }
    
    validates_presence_of :title, :body
end
