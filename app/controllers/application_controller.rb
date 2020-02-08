class ApplicationController < ActionController::Base
  before_action :basic_auth
  
  #下記はサーバーサイド実装の記述
  #before_action :authenticate_user!
  # ログインしていないとルートに飛ぶ
  #before_action :configure_permitted_parameters, if: :devise_controller?
  # 登録時のストロングパラメータ追加
  #protected
  # def configure_permitted_parameters
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname,:lastname,:firstname,:zipcode,:pref,:city,:address,:buildingname,:phone,:birthyear,:birthmonth,:birthday,:lastname_kana,:firstname_kana])
  # end

  private
  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == 'admin' && password == '2222'
    end
  end
end