require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  describe '配送先住所の登録' do
    before do
      @order_address = FactoryBot.build(:order_address)
    end

    it '配送先の情報として、郵便番号・都道府県・市区町村・番地・電話番号が必須であること' do 
      expect(@order_address).to be_valid
    end

    it 'postal_codeが半角のハイフンを含んだ正しい形式でないと保存できないこと' do
      @order_address.postal_code = nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Postal code is invalid. Include hyphen(-)")
    end

    it 'shipment_sourceを選択していないと保存できないこと' do
      @order_address.shipment_source_id = nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Shipment source can't be blank")
    end

    it 'building_nameは空でも保存できること' do
      @order_address.building_name = nil
      expect(@order_address).to be_valid
    end

    it 'tokenがあれば保存できること' do
      expect(@order_address).to be_valid
    end

    it ' tokenがなければ保存できないこと' do
      @order_address.token = nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Token can't be blank")
    end

   
  end
end