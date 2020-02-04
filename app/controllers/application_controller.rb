class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  # ログインしていないとルートに飛ぶ
  before_action :configure_permitted_parameters, if: :devise_controller?
  # 登録時のストロングパラメータ追加
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname,:lastname,:firstname,:zipcode,:pref,:city,:address,:buildingname,:phonee])
  end
end