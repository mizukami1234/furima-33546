class OrderAddress
  include ActiveModel::Model
  attr_accessor :user,:product, :postal_code, :shipment_source_id, :city, :house_number, :building_name, :phone_number, :order_id

  with_options presence: true do

    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)" }
    validates :city, format: { with: /\A[ぁ-んァ-ン一-龥]/, message: "is invalid. Input full-width characters."}  
    validates :phone_number, format: { with: /\A\d{10}\z|\A\d{11}\z/ , message: "is invalid."}
  end

  validates :shipment_source_id, numericality: { other_than: 0, message: "can't be blank" }

  def save

    order = Order.create(user_id:user, product_id: product)
    #Order.create(user_id: user, product_id: product)
    Address.create(postal_code: postal_code, shipment_source_id: shipment_source_id, city: city, house_number: house_number, phone_number: phone_number, order_id: order.id)

  end



end