class ApplicationController < ActionController::Base
  before_action :basic_auth, if: :production?
  #下記はrailsのバージョンが5.2未満のものに使用されるためコメントアウトします
  # protect_from_forgery with: :exception

  # 下記はサーバーサイド実装の記述(確認の為一時的にコメントアウトします)←root_pathにかけたくないので最後に消去します！（代役は記載しました！）
  # before_action :authenticate_user!
  # ログインしていないとルートに飛ぶ
  before_action :configure_permitted_parameters, if: :devise_controller?
  # 登録時のストロングパラメータ追加
  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname,:lastname,:firstname,:lastname_kana,:firstname_kana,:birthyear_id,:birthmonth_id,:birthday_id,:zipcode,:pref_id,:city,:address,:buildingname,:phone])
  end

  def set_card
    if user_signed_in?
      @card=Card.find_by(user_id:current_user.id) #クレジットカード削除の判定に使用しているので消さないでください
    end
  end

  private

  def production?
    Rails.env.production?
  end

  def after_sign_out_path_for(resource_or_scope)
    root_path
  end
  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == 'admin' && password == '2222'
    end
  end
end