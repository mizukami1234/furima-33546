FactoryBot.define do
  factory :product do
    product_name               { "商品名だよ" }
    text                       { "3年前に購入したものの使わずに置いてありました" }
    price                      { 5000 }
    # user_id                  { 2 }
    category_id                { 2 }
    product_condition_id       { 2 }
    shipping_charge_id         { 2 }
    shipment_source_id         { 2 }
    estimated_shipping_date_id { 2 }


    after(:build) do |product|
      product.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end

    association :user

  end
end