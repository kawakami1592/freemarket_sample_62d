class SignupController < ApplicationController
  before_action :user_params
  def index
  end

  def new
    @user = User.new # 新規インスタンス作成
  end

  def create
    @user = User.new(
      nickname: session[:nickname], # sessionに保存された値をインスタンスに渡す
      email: session[:email],
      password: session[:password],
      password_confirmation: session[:password_confirmation],
      last_name: session[:last_name], 
      first_name: session[:first_name], 
      last_name_kana: session[:last_name_kana], 
      first_name_kana: session[:first_name_kana], 
      zipcode: session[:zipcode],
      pref: session[:pref],
      city: session[:city],
      address: session[:address],
      buildingname: session[:buildingname],
      phone: session[:phone],
      birthyear: session[:birthyear],
      birthmonth: session[:birthmonth],
      birthday: session[:birthday],
    )

    if @user.save
　　　# ログインするための情報を保管
      session[:id] = @user.id
      redirect_to done_signup_index_path
    else
      render '/signup/registration'
    end
  end


  def done
    sign_in User.find(session[:id]) unless user_signed_in?
  end

  private

  def user_params
    params.require(:user).permit(:nickname,:lastname,:firstname,:zipcode,:pref,:city,:address,:buildingname,:phone,:birthyear,:birthmonth,:birthday,:lastname_kana,:firstname_kana)
    # 入力された値を受け取る
  end

end
