class ItemsController < ApplicationController
  def index
    # 仮メインページ
  end
  def new
    @item = Item.new
  end
  
end
