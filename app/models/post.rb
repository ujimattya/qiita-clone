class Post < ApplicationRecord
  belongs_to :user
  has_many :favorites
  has_many :users, through: :favorites
  acts_as_taggable
  acts_as_taggable_on :skills, :interests
  validates :user_id, presence: true
  validates :content, presence: true
  validates :title, presence: true, length: { maximum: 30 }
  validates :content, presence: true, length: { maximum: 1000 }
  default_scope -> { order(created_at: :desc) }
end
