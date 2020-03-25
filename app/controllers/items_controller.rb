class ItemsController < ApplicationController
   before_action :authenticate_user!, except:[:index,:show]
   before_action :set_item, only: [:show]
  def index
    @items = Item.where.not(boughtflg_id: '2').includes(:user).last(3)
  end

  def new
    @item = Item.new
    @categories = Category.all
  end
  
  def show

  end
  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
     
    else
      render :new
    end
  end

  def destroy
    item = Item.find_by(params[:id])
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

