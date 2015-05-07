class ProductsController < ApplicationController

before_action :login_required

  def index
    @products = Product.all
    @products_by_author = @products.group_by(&:author)
  end



  def show
    @product = Product.find(params[:id])
  end




end
