class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  # adminかuserかどうかでログイン後の遷移先を指定するためのメソッド。
  def after_sign_in_path_for(resource)
    if current_admin
      flash[:notice] = "管理者としてログインに成功しました。"
      admin_path
    else
      root_path
    end
  end

  # adminかuserかどうかでログアウト後の遷移先を指定するためのメソッド。
  def after_sign_out_path_for(resource)
    if resource == :admin
      new_admin_session_path
    else
      root_path
    end
  end

  protected
    def configure_permitted_parameters
      # 新規登録時に「:name, :prefecture_id, :municipality」のカラムを追加。またユーザーのプレイヤーを作成するために「players_attributes」を記述。
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :prefecture_id, :municipality, players_attributes: [:name, :myself_status]])
    end
end
