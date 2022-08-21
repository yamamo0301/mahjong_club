class Admin::HomesController < ApplicationController
  before_action :move_to_signed_in

  def top
    @users = User.all
  end


  private

  def move_to_signed_in
    unless admin_signed_in?
      redirect_to  '/admin/sign_in'
    end
  end
end
