class ItemsController < ApplicationController
  before_action :authenticate_user!, except:[:index]
  def index
    @items = Item.all
  end
  

  def new
    @item = Item.new
    @categories = Category.all
  end
  
  # def pay
  #   Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
  #   charge = Payjp::Charge.create(
  #   amount: @item.price,
  #   card: params['payjp-token'],
  #   currency: 'jpy'
  #   )
  # end

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

