class ItemsController < ApplicationController
  before_action :authenticate_user!, except:[:index]
  def index
    @items = Item.where.not(boughtflg_id: '2').includes(:user).last(3)
  end

  def new
    @item = Item.new
    @categories = Category.all
    @category_parent =  Category.where("ancestry is null")
    # Category.where(ancestry: nil).each do |parent|
    #   @category_parent == parent.name
  #  end
  end
  
  def create
    @item = Item.new(item_params)

    if @item.save
      redirect_to root_path
     
    else
      render :new
    end
  end

  #親カテゴリーが選択された後に動くアクション
  def get_category_children
    #選択された親カテゴリーに紐付く子カテゴリーの配列を取得
    @category_children = Category.find_by(category_name: "#{params[:parent_name]}", ancestry: nil).children
  end

  #子カテゴリーが選択された後に動くアクション
  def get_category_grandchildren
    #選択された子カテゴリーに紐付く孫カテゴリーの配列を取得
    @category_grandchildren = Category.find("#{params[:child_id]}").children
  end

  

  private

  def item_params
    params.require(:item).permit(:name, :text, :category_id, :condition_id, :deliverycost_id, :pref_id, :delivery_days_id, :price, images: []).merge(user_id: current_user.id, boughtflg_id:"1")
  end
 
end