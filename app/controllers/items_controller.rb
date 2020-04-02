class ItemsController < ApplicationController
  
   before_action :authenticate_user!, except:[:index,:show]
   before_action :set_item, only: [:show,:edit]
   before_action :set_card, except:[:index]  #クレジットカード削除の判定に使用しているので消さないでください


  def index
    @items = Item.where.not(boughtflg_id: '2').includes(:user).last(3)

    if user_signed_in?
      if :item.present?
        @currentitem=Item.find_by(user_id:current_user.id) 
      end
    end
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
      redirect_to root_path
     
    else
      render :new
    end
  end

  def edit 
    @category_grandchildren = Category.find(@item.category_id)
    @category_parent =  Category.where("ancestry is null")
    # binding.pry
    # @category_children = @grandchildren_category.parent
    # @category_parent = @children_category.parent

  end

  def update
    @item.update(item_params)
    redirect_to root_path
  end

  def destroy
    item = Item.find_by(id: params[:id])
    if item.present?
      if item.destroy
        redirect_to root_path, notice: "削除に成功しました"
      else
        redirect_to root_path, notice: "削除に失敗しました"
      end
    else
      redirect_to root_path, notice: "商品が見つかりません"
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :text, :category_id, :condition_id, :deliverycost_id, :pref_id, :delivery_days_id, :price, images: []).merge(user_id: current_user.id, boughtflg_id:"1")
  end
  def set_item
    @item = Item.find(params[:id])
  end
end

