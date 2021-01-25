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



  with_options presence: true do
    validates :product_name
    validates :text
  end



  with_options numericality: { other_than: 1} do 
    validates :category_id
    validates :product_condition_id
    validates :shipping_charge_id
    validates :estimated_shipping_date_id
  end

  validates :shipment_source_id, numericality: { other_than: 0 }
  validates :price, presence: true, numericality: { :greater_than_or_equal_to => 300, :less_than_or_equal_to => 9999999}, format: { with: /\A[0-9]+\z/ , message: '半角数字のみ' }


 


end
