class OrderAddress
  include ActiveModel::Model
  attr_accessor :user_id, :product_id, :nickname, :postal_code, :shipment_source_id, :city, :house_number, :building_name, :phone_number :order_id

  
end