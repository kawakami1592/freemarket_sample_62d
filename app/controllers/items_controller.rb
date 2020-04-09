class ItemsController < ApplicationController
  
   before_action :authenticate_user!, except:[:index,:show]
   before_action :set_item, only: [:show, :buy, :pay, :edit, :update]
   before_action :set_card, except:[:index]  #クレジットカード削除の判定に使用しているので消さないでください
  #  before_action :correct_images, only: [:update]

  def index
    @items = Item.includes(:user).last(3)
  end

  def show
  end

  def new
    @item = Item.new
    @category_parent =  Category.where("ancestry is null")
  end

  # 親カテゴリーが選択された後に動くアクション
  def category_children
    @category_children = Category.find("#{params[:parent_id]}").children
    #親カテゴリーに紐付く子カテゴリーを取得
  end

  # 子カテゴリーが選択された後に動くアクション
  def category_grandchildren
    @category_grandchildren = Category.find("#{params[:child_id]}").children
    #子カテゴリーに紐付く孫カテゴリーの配列を取得
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      DeleteUnreferencedBlobJob.perform_later 
      redirect_to root_path
     
    else
      render :new
    end
  end

  def edit 
    if @item.user_id == current_user.id
      @category_grandchildren = Category.find(@item.category_id)
      @category_parent =  Category.where("ancestry is null")
    else
      redirect_to root_path,notice: "出品者のみ編集を行うことができます"
    end
  end

  def update
    if @item.present?
      if @item.update(item_params)
        @item.correct_images
        DeleteUnreferencedBlobJob.perform_later
        redirect_to root_path, notice: "商品情報を編集しました"
      else
        redirect_to edit_item_path ,notice: "商品情報を編集できていません"
      end
    else
      redirect_to root_path, notice: "商品が見つかりません"
    end
  end

  def destroy
    item = Item.find_by(id: params[:id])
    if item.present?
      if item.destroy
        DeleteUnreferencedBlobJob.perform_later 
        redirect_to root_path, notice: "削除に成功しました"
      else
        redirect_to root_path, notice: "削除に失敗しました"
      end
    else
      redirect_to root_path, notice: "商品が見つかりません"
    end
  end

  def buy
    if @item.boughtflg_id == 2
      # 購入済みの場合はトップに遷移し売り切れの旨を表示
      redirect_to root_path, notice: "この商品は売り切れました"
    elsif @item.user_id == current_user.id
      # その商品の出品者の場合は詳細画面に戻り、出品者は購入できない旨を表示
      redirect_to item_path(@item), notice: "出品者は商品を購入できません"
    elsif @card.blank?
      # カード情報が登録されていない場合は登録画面へ遷移
      redirect_to new_card_path, notice: "クレジットカード情報を登録してください"
    else
      Payjp.api_key = Rails.application.credentials.dig(:payjp, :PAYJP_SECRET_KEY)
      # 保管した顧客IDでpayjpから情報取得
      customer = Payjp::Customer.retrieve(@card.customer_id)
      # 保管したカードIDでpayjpから情報取得、カード情報表示のためインスタンス変数に代入
      @default_card_information = customer.cards.retrieve(@card.card_id)
    end
    @user = current_user
  end

  def pay
    Payjp.api_key = Rails.application.credentials.dig(:payjp, :PAYJP_SECRET_KEY)
    begin
      charge = Payjp::Charge.create(
        amount: @item.price,
        customer: @card.customer_id,
        currency: 'jpy'
      )
      @item.update!(boughtflg_id: '2')
      redirect_to root_path, notice: "商品の購入が完了しました"
    # カードの有効期限が切れている等、何らかの理由で決済に失敗した場合の例外処理をrescue以降に記述
    # エラー情報はターミナルに出力する（エンドユーザに提示する内容ではない。PayjpのAPIを参照）
    rescue Payjp::PayjpError => e
      body = e.json_body
      err  = body[:error]
      puts "Status is: #{e.http_status}"
      puts "Type is: #{err[:type]}"
      puts "Code is: #{err[:code]}"
      puts "Param is: #{err[:param]}"
      puts "Message is: #{err[:message]}"
      redirect_to item_path(@item), notice: "クレジットカード決済処理が失敗しました"
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :text, :category_id, :condition_id, :deliverycost_id, :pref_id, :delivery_days_id, :price, images: []).merge(user_id: current_user.id, boughtflg_id:"1")
  end

  def set_item
    @item = Item.find_by(id:params[:id])
  end

  # 画像削除用のメソッドです。submitされた画像のなかに当初テーブルにデータが入っていたのになくなっているものを削除します。
  def correct_images
    # submitされた画像のパラメータをこのメソッド内で複数回使用するのであらかじめ定義
    def image_params
      params.require(:item).permit(images:[])
    end
    # テーブルの画像とsubmitされた画像に差異がある時のみ実行
    if @item.images != Items.new(image_params)
      # submitされた画像のハッシュ値のみで配列を作成(このメソッドでもう一度使用するためインスタンス変数で定義)
      image_params.each do |params|
        @need_images = params
      end
      # 現在保存されている画像を１枚ずつ取り出し先ほど作った配列の値と一致しないものを削除
      @item.images do |noneed_image|
        @item.imagespurge(noneed_image) if @need_images.exclude?(noneed_image)
      end
    end
    #処理を終えたら上書き保存（メソッドになるので挙動の前に変数をつけない）
    update(item_params)
  end

end

