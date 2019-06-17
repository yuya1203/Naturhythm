class RankingsController < ApplicationController
  before_action :require_user_logged_in
  
  def favorite
    @ranking_counts = Favorite.ranking
    @microposts = Micropost.find(@ranking_counts.keys)
  end

  def follower
    @ranking_counts = Relationship.ranking
    @users = User.find(@ranking_counts.keys)
  end

  # def evaluation
  #   @ranking_counts = Micropost.ranking
  #   @users = Micropost.find(@ranking_counts.keys)
  # end
end
