class CategorysController < ApplicationController
  def index
    @categorys = Category.all
  end
end
