class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product, only: [:index, :create]
  before_action :move_to_root_path, only: :index



def index
  @order_address = OrderAddress.new
end

def new
end


def create
  @order_address = OrderAddress.new(order_params)
    if @order_address.valid?
      pay_product
      @order_address.save
      redirect_to root_path
    else
      render :index
    end

end


private

def set_product
  @product = Product.find(params[:product_id])
end

def order_params
  params.require(:order_address).permit(:postal_code, :shipment_source_id, :city, :house_number, :building_name, :phone_number, :prefecture_id).merge(user: current_user.id, product: params[:product_id], token: params[:token])
end

def pay_product
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]  # 自身のPAY.JPテスト秘密鍵を記述しましょう
    Payjp::Charge.create(
      amount: @product.price,
      card: order_params[:token],    # カードトークン
      currency: 'jpy'                 # 通貨の種類（日本円）
    )
end

def move_to_root_path
  @product = Product.find(params[:product_id])
  if current_user.id == @product.user.id
    redirect_to root_path
  end
end



end
