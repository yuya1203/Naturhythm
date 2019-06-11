class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :micropost

  def self.ranking
    self.group(:micropost_id).order('count_micropost_id DESC').limit(10).count(:micropost_id)
  end
end
