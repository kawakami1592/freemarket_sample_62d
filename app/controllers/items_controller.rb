class ItemsController < ApplicationController
  before_action :authenticate_user!, except:[:index]
  def index
    @items = Item.includes(:user).last(3)
  end

  def new
    @item = Item.new
  end
  
end
