class ItemsController < ApplicationController
  before_action :authenticate_user!, except:[:index]
  def index
    # 仮メインページ
  end
  def new
    @item = Item.new
  end
  
end
