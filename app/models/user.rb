class User < ApplicationRecord
    attr_accessor :remember_token
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
    
    # 渡された文字列のハッシュ値を返す
    def User.digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                    BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end
  
    # ランダムなトークンを返す
    def User.new_token
      SecureRandom.urlsafe_base64
    end
    
    def remember
      self.remember_token = User.new_token
      update_attribute(:remember_digest, User.digest(remember_token))
    end
    
    # 渡されたトークンがダイジェストと一致したらtrueを返す
    def authenticated?(remember_token)
      return false if remember_digest.nil?
      BCrypt::Password.new(remember_digest).is_password?(remember_token)
    end
    
    def forget
      update_attribute(:remember_digest, nil)
    end

end
