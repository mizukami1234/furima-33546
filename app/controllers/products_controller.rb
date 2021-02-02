class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :move_to_index, except: [:index, :show, :new, :create]
  before_action :move_to_top, only: :edit
  
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
  end

  def edit
  end

  def update 
    if @product.update(product_params)
      redirect_to product_path(@product.id)
    else
      render 'edit'
    end
  end

  def destroy
    if @product.destroy
        redirect_to root_path
    else
      redirect_to product_path(@product.id)
    end
  end


private

def product_params
    params.require(:product).permit(:product_name, :text, :price, :image, :category_id, :product_condition_id, :shipping_charge_id, :shipment_source_id, :estimated_shipping_date_id).merge(user_id: current_user.id)
end

def set_product
  @product = Product.find(params[:id])
end

def move_to_index
  @product = Product.find(params[:id])
  unless current_user.id == @product.user.id
    redirect_to action: :index
  end
end

def move_to_top
  if @product.order.present?
    redirect_to root_path
  end
end



end
