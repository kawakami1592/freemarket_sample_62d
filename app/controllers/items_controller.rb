class ItemsController < ApplicationController
  before_action :authenticate_user!, except:[:index,:show]
  # before_action :set_item, only: [:show]
  def index
    @items = Item.all
  end

  def new
    @item = Item.new
    @categories = Category.all
  end
  
  def show
      #@item = Item.find(params[:id])
       # @item = Product.where(user_id: @product.user_id)
       # @next_product = Product.where("id > ?", @product.id).order("id ASC").first
       # @prev_product = Product.where("id < ?", @product.id).order("id DESC").first
  end
  def create
    @item = Item.new(item_params)

    if @item.save
      redirect_to  edit_user_path
     
    else
      render :new
    end
  end

  

  private

  def item_params
    params.require(:item).permit(:name, :text, :category_id, :condition_id, :deliverycost_id, :pref_id, :delivery_days_id, :price, images: []).merge(user_id: current_user.id, boughtflg_id:"1")
  end
 
end

