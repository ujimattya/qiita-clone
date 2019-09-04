class User < ApplicationRecord
    before_save { self.email = email.downcase }
    has_many :posts, dependent: :destroy
    has_many :favorites
    has_many :favposts, through: :favorites, source: :post
    validates :name,  presence: true, length: { maximum: 50 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 225 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: true
    has_secure_password
    validates :password, presence: true, length: { minimum: 6 }
    validates :profile, presence: true, length: { maximum: 160 }
    
    def like(post)
      favorites.find_or_create_by(post_id: post.id)
    end
    
    def unlike(post)
       favorite = favorites.find_by(post_id: post.id)
       favorite.destroy if favorite
    end
    
    
    
    def  favpost?(post)
      self.favposts.include?(post)
    end
end
