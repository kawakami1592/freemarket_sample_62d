class ItemsController < ApplicationController
  before_action :authenticate_user!, except:[:index]
  def index
    @items = Item.preload(:user)
    # binding.pry
  end

  def new
    @item = Item.new
  end
  
end
