class ItemsController < ApplicationController
  before_action :authenticate_user!, except:[:index,:show]
  # before_action :set_item, only: [:show]
  def index
    @items = Item.all
  end
  def new
    @item = Item.new
  end
  
  def show
      #@item = Item.find(params[:id])
       # @item = Product.where(user_id: @product.user_id)
       # @next_product = Product.where("id > ?", @product.id).order("id ASC").first
       # @prev_product = Product.where("id < ?", @product.id).order("id DESC").first
  end
  private
  def user_params
    params.require(:user).permit(:nickname,:lastname,:firstname,:lastname_kana,:firstname_kana,:birthyear_id,:birthmonth_id,:birthday_id,:zipcode,:pref_id,:city,:address,:buildingname,:phone)
    # 入力された値を受け取る
  end

  # def set_item
  #   @item = Item.find(params[:id])
  # end
end
