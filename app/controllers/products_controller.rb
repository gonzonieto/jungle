class ProductsController < ApplicationController

  def index
    @products = Product.all.order(created_at: :desc)
    @subtitle = [
      'Where you can find any plants!',
      "We've got fun and games!",
      'We take it day by day',
      'It gets worse here every day',
      'Feel my, my, my serpentine'
    ].sample
  end

  def show
    @product = Product.find params[:id]
  end

end