class GuidesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_card  #クレジットカード削除の判定に使用しているので消さないでください  

  def show
  end
end
