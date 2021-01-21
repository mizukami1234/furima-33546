require 'rails_helper'
RSpec.describe Product, type: :model do
  before do
    @product = FactoryBot.build(:product)
  end


  describe '商品出品機能' do

    context '商品出品できるとき' do
      it '必要事項が記入されていれば出品できる' do
        expect(@product).to be_valid
      end
     end


    context '商品出品できないとき' do      

      it '商品画像が空だと出品できない' do
        @product.image = nil
        @product.valid?
        expect(@product.errors.full_messages).to include ( "Image can't be blank" )
      end

      it '商品名が空だと出品できない' do
        @product.product_name = ""
        @product.valid?
        expect(@product.errors.full_messages).to include ( "Product name can't be blank" )

      end

      it '商品説明欄が空だと出品できない' do
        @product.text = ""
        @product.valid?
        expect(@product.errors.full_messages).to include ( "Text can't be blank" )
      end

      it 'カテゴリーが空だと出品できない' do
        @product.category_id = "--"
        @product.valid?
        expect(@product.errors.full_messages).to include ( "Category is not a number" )
      end

      it '商品の状態欄が空だと出品できない' do
        @product.product_condition_id = "--"
        @product.valid?
        expect(@product.errors.full_messages).to include ( "Product condition is not a number" )
      end

      it '配送料の負担欄が空だと出品できない' do
        @product.shipping_charge_id = "--"
        @product.valid?
        expect(@product.errors.full_messages).to include ( "Shipping charge is not a number" )
      end

      it '発送源の地域が空だと出品できない' do
        @product.shipment_source_id = "--"
        @product.valid?
        expect(@product.errors.full_messages).to include ( "Shipment source is not a number" )
      end

      it '発送までの日数が空だと出品できない' do
        @product.estimated_shipping_date_id = "--"
        @product.valid?
        expect(@product.errors.full_messages).to include ( "Estimated shipping date is not a number" )
      end

      it '出品したユーザーが紐付いていないと出品できない' do
        @product.user = nil
        @product.valid?
        expect(@product.errors.full_messages).to include ( "User must exist" )
      end

      #price欄にかけたバリデーションのテスト
      it '価格欄が空だと出品できない' do
        @product.price = nil
        @product.valid?
        expect(@product.errors.full_messages).to include ( "Price can't be blank" )
      end

      it '価格が299円以下だと出品できない' do
        @product.price = 200
        @product.valid?
        expect(@product.errors.full_messages).to include ( "Price must be greater than or equal to 300" )
      end

      it '価格が10000000円以上だと出品できない' do
        @product.price = 10000000
        @product.valid?
        expect(@product.errors.full_messages).to include ( "Price must be less than or equal to 9999999" )
      end

      it '価格欄が全角数字なら出品できない' do
        @product.price = "４００"
        @product.valid?
        expect(@product.errors.full_messages).to include ( "Price is not a number" )
      end

      it '価格欄が半角文字なら出品できない' do
        @product.price = "abc"
        @product.valid?
        expect(@product.errors.full_messages).to include ( "Price is not a number" )
      end



    end

  end
end