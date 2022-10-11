# frozen_string_literal: true

class Admin::SessionsController < Devise::SessionsController
  before_action :move_to_admin_signed_in, if: :admin_sign_out
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

  # TODO : admin_sign_outのURLが直接リクエストされたときにadmin_sign_in画面へ遷移させるために記述
  def access_authorizations
  end

  protected
    # If you have extra params to permit, append them to the sanitizer.
    # def configure_sign_in_params
    # devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
    # end

    # TODO : admin_sign_outのURLが直接リクエストされたときにadmin_sign_in画面へ遷移させるために記述
    def admin_sign_out
      request.url.include?("/admin/sign_out")
    end
    # TODO : admin_sign_outのURLが直接リクエストされたときにadmin_sign_in画面へ遷移させるために記述
    def move_to_admin_signed_in
      unless admin_signed_in?
        redirect_to "/admin/sign_in"
      end
    end
end
