class OrdersController < ApplicationController

def index
  @product = Product.find(params[:product_id])
  @order_address = OrderAddress.new
end

def new
end


def create
  binding.pry
  @product = Product.find(params[:product_id])
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

def order_params
  params.permit(:postal_code, :shipment_source_id, :city, :house_number, :building_name, :phone_number, :prefecture_id).merge(user: current_user.id, product: params[:product_id], token: params[:token])
end

def pay_product
  Payjp.api_key = "sk_test_230ca29363dd9a8a84758209"  # 自身のPAY.JPテスト秘密鍵を記述しましょう
    Payjp::Charge.create(
      card: order_params[:token],    # カードトークン
      currency: 'jpy'                 # 通貨の種類（日本円）
    )
end

end
