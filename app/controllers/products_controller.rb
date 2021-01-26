class ProductsController < ApplicationController
  before_action :move_to_index, except: [:index, :show]
  
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

  def show
    @product = Product.find(params[:id])
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update 
    product = Product.find(params[:id])
    if product.update(product_params)
      redirect_to product_path(product.id)
    else
      render 'edit'
    end
  end


private

def product_params
    params.require(:product).permit(:product_name, :text, :price, :image, :category_id, :product_condition_id, :shipping_charge_id, :shipment_source_id, :estimated_shipping_date_id).merge(user_id: current_user.id)
end

def move_to_index
  product = Product.find(params[:id])
  unless current_user.id == product.user.id
    redirect_to action: :index
  end
end

end
