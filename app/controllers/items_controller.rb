class ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def new
    @item = Item.new
    @categories = Category.all
  end
  
  def create
    @item = Item.new(item_params)

    if @item.save
      redirect_to  edit_user_path
     
    else
      render :new
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    redirect_to root_path
  end

  private

  def item_params
    params.require(:item).permit(:name, :text, :category_id, :condition_id, :deliverycost_id, :pref_id, :delivery_days_id, :price, images: [])
  end

  # .merge(user_id: current_user.id)
end