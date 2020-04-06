class GuidesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_card  #クレジットカード削除の判定に使用しているので消さないでください  
  def delivery
  end

  def price
  end
  
  def prohibited_item
  end
  
  def prohibited_conduct
  end
  
  def counterfeit_goods
  end
  
  def stolen_goods
  end
  
  def seller_terms
  end
  
end
