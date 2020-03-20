class ItemsController < ApplicationController
   before_action :authenticate_user!, except:[:index,:show]
   before_action :set_item, only: [:show, :edit, :update]

  def index
    @items = Item.where.not(boughtflg_id: '2').includes(:user).last(3)

    if user_signed_in?
      if :item.present?
        @currentitem=Item.find_by(user_id:current_user.id) 
      end
    end
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
      redirect_to  edit_user_path(@item.user_id)
     
    else
      render :new
    end
  end

  def edit   
  end

  def update
    @item.update(item_params)
  end

  private

  def item_params
    params.require(:item).permit(:name, :text, :category_id, :condition_id, :deliverycost_id, :pref_id, :delivery_days_id, :price, images: []).merge(user_id: current_user.id, boughtflg_id:"1")
  end
  def set_item
    @item = Item.find(params[:id])
  end
end

