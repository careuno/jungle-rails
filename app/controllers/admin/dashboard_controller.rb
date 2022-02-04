class Admin::DashboardController < ApplicationController
  http_basic_authenticate_with name: ENV['HTTP_USER'], password: ENV['HTTP_PASS']
  def show
    @num_products = Product.count
    @num_category = Category.count
  end
end
