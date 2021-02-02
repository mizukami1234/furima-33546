FactoryBot.define do
  factory :order_address do

      postal_code { '221-0544'}
      shipment_source_id { 3 }
      city { '横浜市' }
      house_number { '23-3' }
      phone_number { '09043434343'}
      building_name { "ライオンズ" }

      token { "tok_abcdefghijk00000000000000000" }

  end
end