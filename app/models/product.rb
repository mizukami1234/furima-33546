class Product < ApplicationRecord

  belongs_to :user
  has_one_attached :image


  validates :product_name, presence: true
  validates :text, presence: true
  validates :price, presence: true
  validates :category_id, presence: true
  validates :product_condition_id, presence: true
  validates :shipping_charge_id, presende: true
  validates :shipment_source_id, presence: true
  validates :estimated_shipping_date_id, presence: true



end
