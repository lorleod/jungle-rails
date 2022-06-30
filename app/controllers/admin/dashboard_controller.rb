class Admin::DashboardController < ApplicationController

  http_basic_authenticate_with name: ENV["USERNAME"], password: ENV["PASSWORD"]

  def show
    @products = Product.all.order(created_at: :desc)
    @categories = Category.all.order(created_at: :desc)
  end
end
