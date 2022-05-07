class Admin::CategoriesController < ApplicationController

  http_basic_authenticate_with name: ENV['ADMIN_NAME'], password: ENV['ADMIN_PW']

  def index
    @categories = Category.order(id: :desc).all.map do |category|
      { name: category[:name],
        product_count: Product.where(category_id: category[:id]).count }
    end
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to [:admin, :categories], notice: 'Category created!'
    else
      render :new
    end
  end

  private

  def category_params
    params.require(:category).permit(
      :name
    )
  end

end
