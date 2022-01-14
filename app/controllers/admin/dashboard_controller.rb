class Admin::DashboardController < ApplicationController
  
  http_basic_authenticate_with name: ENV["JUNGLE_USERNAME"], password: ENV["JUNGLE_PASSWORD"]

  def show
    @products_count =  Product.count
    @categories_count = Category.count
    @orders_count = Order.count
  end
end