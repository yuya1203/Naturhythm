class Micropost < ApplicationRecord
  belongs_to :user
  
  validates :content, presence: true, length: { maximum: 255 }
  
  has_many :reverses_of_favorite, class_name: 'Favorite', foreign_key: 'micropost_id'
  has_many :reverses_of_likes, through: :reverses_of_favorite, source: :user
end
