class Admin::DashboardController < Admin::AdminController
  
  def show
    @product_count = Product.count
    @category_count = Category.count
  end
  
end
