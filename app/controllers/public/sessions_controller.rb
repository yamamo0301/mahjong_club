# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  before_action :user_state, only: [:create]
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  def after_sign_in_path_for(resource)
    user_path(current_user.id)
  end


  protected
  # TODO : 退会しているかを判断するメソッド
  def user_state
    # TODO : 入力されたemailからアカウントを1件取得
    @user_email = User.find_by(email: params[:user][:email])
    # TODO : アカウントを取得できなかった場合、このメソッドを終了する
    return if !@user_email
    # TODO : 取得したアカウントのパスワードと入力されたパスワードが一致してるかを判別
    if @user_email.valid_password?(params[:user][:password]) && @user_email.is_deleted
      redirect_to new_user_registration_path
    end
  end

end
