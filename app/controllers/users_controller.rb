class UsersController < ApplicationController
   
  before_action :set_user, only: [:show, :edit]

  def edit
    # ユーザー登録情報の変更画面へ
  end

  def update
    # ユーザー登録情報の変更を保存する
    if current_user.update(user_params)
      # ログインしているユーザーが入力した値を保存する
      redirect_to root_path
      # 成功したら、ルートにリダイレクトする
    else
      render :edit
      # 失敗したら、変更画面を呼び出す
    end
  end

  def show
      #マイページへ
  end

  private

  def user_params
    params.require(:user).permit(:nickname,:lastname,:firstname,:zipcode,:pref,:city,:address,:buildingname,:phone,:birthyear,:birthmonth,:birthday,:lastname_kana,:firstname_kana)
    # 入力された値を受け取る
  end

  def set_user
    @user = User.find(params[:id])
  end

end