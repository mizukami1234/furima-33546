class ProductsController < ApplicationController
  
  def index 
  end
  
  def new
  end

  def create(product_params)
  end
  


  private

  def product_params
    params.require(:product).permit(:product_name, :text, :price, :image).merge(user_id: current_user.id)
  end
end
