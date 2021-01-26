class ProductsController < ApplicationController
  
  def index 
    @products = Product.includes(:user).order("created_at DESC")
  end
  
  def new
    @product = Product.new
  end


  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to root_path
    else
      render :new
    end
  end


  private

  def product_params
    params.require(:product).permit(:product_name, :text, :price, :image, :category_id, :product_condition_id, :shipping_charge_id, :shipment_source_id, :estimated_shipping_date_id).merge(user_id: current_user.id)
  end
end
