class Admin::UsersController < ApplicationController
  def search
    if params[:prefecture_id].present?
      @users = User.where(prefecture_id: params[:prefecture_id])
    else
      @users = User.none
    end
  end
end