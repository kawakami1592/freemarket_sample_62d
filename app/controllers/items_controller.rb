class ItemsController < ApplicationController
  
  def index
    # 仮メインページ
  end
  
  def new
    @item = Item.new
  end
  
  # def pay
  #   Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
  #   charge = Payjp::Charge.create(
  #   amount: @item.price,
  #   card: params['payjp-token'],
  #   currency: 'jpy'
  #   )
  # end

end
