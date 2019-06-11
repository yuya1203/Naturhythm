class Micropost < ApplicationRecord
  belongs_to :user
  
  validates :bottle_name, presence: true
  validates :producer, presence: true
  validates :production_area, presence: true
  validates :image, presence: true
  validates :content, presence: true, length: { maximum: 255 }

  has_many :favorites, dependent: :destroy
  has_many :users, through: :favorites, source: :user
  has_many :comments, dependent: :destroy
  
  mount_uploader :image, ImageUploader

  acts_as_taggable
  acts_as_taggable_on :tag_list
end
