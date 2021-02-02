require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  describe '配送先住所の登録' do
    before do
      @user = FactoryBot.create(:user)
      @product = FactoryBot.create(:product)
      @order_address = FactoryBot.build(:order_address, user: @user.id, product: @product.id)
      sleep 1
    end

    context '商品が購入できる場合' do
      it '配送先の情報として、カード情報・郵便番号・都道府県・市区町村・番地・電話番号が必須であること' do
        expect(@order_address).to be_valid
      end

      it 'building_nameは空でも保存できること' do
        @order_address.building_name = nil
        expect(@order_address).to be_valid
      end

      it 'building_nameが空でも保存できること' do
        @order_address.building_name = nil
        expect(@order_address).to be_valid
      end
    end

    context '商品が購入できない場合' do
      it 'postal_codeが半角のハイフンを含んだ正しい形式でないと保存できないこと' do
        @order_address.postal_code = '1234567'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
      end

      it 'shipment_sourceを選択していないと保存できないこと' do
        @order_address.shipment_source_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Shipment source can't be blank")
      end

      it 'tokenがなければ保存できないこと' do
        @order_address.token = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Token can't be blank")
      end

      it 'userが紐付いていないと登録できない' do
        @order_address.user = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("User can't be blank")
      end

      it 'productが紐付いていないと登録できない' do
        @order_address.product = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Product can't be blank")
      end

      it 'cityが半角では登録できない' do
        @order_address.city = 'ﾖｺﾊﾏｼ'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('City is invalid. Input full-width characters.')
      end

      it '電話番号が12桁では登録できない' do
        @order_address.phone_number = '123456789012'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Phone number is invalid.')
      end

      it 'shipment_source_idが空(0)だと登録できない' do
        @order_address.shipment_source_id = 0
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Shipment source can't be blank")
      end
    end
  end
end
