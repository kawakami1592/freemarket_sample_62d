class UsersController < ApplicationController
   
  before_action :set_user, only: [:show, :edit]
  before_action :authenticate_user!
  before_action :set_current_item #出品者かどうかの判定に使用しているので消さないでください
  before_action :set_card  #クレジットカード削除の判定に使用しているので消さないでください
  
  def index
  end

  def edit
    # ユーザー登録情報の変更画面へ
    # render "users/#{params[:viewname]}" #viewファイルの呼び出し場所を、app/views/usersのファイルに指定しました
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
  end

  def logout
  end


  private

  def user_params
    params.require(:user).permit(:nickname,:lastname,:firstname,:lastname_kana,:firstname_kana,:birthyear_id,:birthmonth_id,:birthday_id,:zipcode,:pref_id,:city,:address,:buildingname,:phone)
    # 入力された値を受け取る
  end

  def set_user
    @user = User.find(params[:id])
  end

  def set_current_item
    if :item.present?
      @currentitem=Item.find_by(user_id:current_user.id) #出品者かどうかの判定に使用しているので消さないでください
    end
  end


end