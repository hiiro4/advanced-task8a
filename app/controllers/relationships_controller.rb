class RelationshipsController < ApplicationController
  def create
  current_user.follow(params[:user_id])#followeはモデルで定義したものからa
  redirect_to request.referer
  end

  def destroy
  current_user.unfollow(params[:user_id])#unfolloweはモデルで定義したものからa
  redirect_to request.referer
  end
end
