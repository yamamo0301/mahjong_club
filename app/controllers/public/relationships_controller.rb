class Public::RelationshipsController < ApplicationController
  before_action :authenticate_user!

   # フォローをするとき。
  def create
    current_user.follow(params[:user_id])
    redirect_to request.referer
  end
  # フォローを外すとき。
  def destroy
    current_user.unfollow(params[:user_id])
    redirect_to request.referer
  end
  # フォローの一覧。
  def followings
    user = User.find(params[:user_id])
    # followingsについてはuser.rbに記述。
    @users = user.followings
  end
  # フォロワーの一覧。
  def followers
    user = User.find(params[:user_id])
    # followersについてはuser.rbに記述
    @users = user.followers
  end

end
