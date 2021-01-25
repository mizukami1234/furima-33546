class Product < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :product_condition
  belongs_to :shipping_charge
  belongs_to :shipment_source
  belongs_to :estimated_shipping_date

  belongs_to :user

  has_one_attached :image
  validates :image, presence: true


  validates :product_name, presence: true
  validates :text, presence: true
  validates :category_id, numericality: { other_than: 1 } 
  validates :product_condition_id, numericality: { other_than: 1 } 
  validates :shipping_charge_id, numericality: { other_than: 1 }
  validates :shipment_source_id, numericality: { other_than: 0 }
  validates :estimated_shipping_date_id, numericality: { other_than: 1 }
  validates :price, presence: true, numericality: { :greater_than_or_equal_to => 300, :less_than_or_equal_to => 9999999}, format: { with: /\A[0-9]+\z/ , message: '半角数字のみ' }


 


end
