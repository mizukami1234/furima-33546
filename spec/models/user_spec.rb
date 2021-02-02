require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録・ログインログアウト機能' do
    it 'ニックネーム、姓、名、メール、パスワード、誕生日がある場合、有効である' do
      expect(@user).to be_valid
    end

    it 'nicknameが空では登録できない' do
      @user.nickname = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Nickname can't be blank")
    end

    it 'emailが空では登録できない' do
      @user.email = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it '重複したemailが存在する場合登録できない' do
      @user.save
      another_user = FactoryBot.build(:user)
      another_user.email = @user.email
      another_user.valid?
      expect(another_user.errors.full_messages).to include('Email has already been taken')
    end

    it 'emailに@が含まれてなければ登録できない' do
      @user.email = 'test.com'
      @user.valid?
      expect(@user.errors.full_messages).to include('Email is invalid')
    end

    it 'passwordが空では登録できない' do
      @user.password = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it 'passwordが5文字以下では登録できない' do
      @user.password = 'aaaaa'
      @user.password_confirmation = 'aaaaa'
      @user.valid?
      expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
    end

    it 'passwordが半角数字だけでは登録できない' do
      @user.password = '1111111'
      @user.password_confirmation = '1111111'
      @user.valid?
      expect(@user.errors.full_messages).to include('Password 英数字混合6文字以上')
    end

    it 'passwordが半角英字だけでは登録できない' do
      @user.password = 'aaaaaaa'
      @user.password_confirmation = 'aaaaaaa'
      @user.valid?
      expect(@user.errors.full_messages).to include('Password 英数字混合6文字以上')
    end

    it 'passwordが全角では登録できない' do
      @user.password = 'あいうえおあ'
      @user.password_confirmation = 'あいうえおあ'
      @user.valid?
      expect(@user.errors.full_messages).to include('Password 英数字混合6文字以上')
    end

    it 'passwordが存在してもpassword_confirmationが空では登録できない' do
      @user.password_confirmation = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'passwordとpassword_confirmationが一致しなければ登録できない' do
      @user.password = 'abcd1234'
      @user.password = 'abcd12345'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'ユーザー本名は、苗字が必須であること' do
      @user.last_name_kanji = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name kanji can't be blank")
    end

    it 'ユーザー本名は、名前が必須であること' do
      @user.first_name_kanji = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("First name kanji can't be blank")
    end

    it 'ユーザー本名の苗字のフリガナが必須であること' do
      @user.last_name_kana = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name kana can't be blank")
    end

    it 'ユーザー本名の名前のフリガナが必須であること' do
      @user.first_name_kana = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("First name kana can't be blank")
    end

    # last_name_kanji に関して
    it 'ユーザー本名(苗字) は、半角英字では登録できないこと' do
      @user.last_name_kanji = 'aiueo'
      @user.valid?
      expect(@user.errors.full_messages).to include('Last name kanji 全角漢字・かな・カタカナを使用してください')
    end

    it 'ユーザー本名(苗字) は、半角数字では登録できないこと' do
      @user.last_name_kanji = '11111'
      @user.valid?
      expect(@user.errors.full_messages).to include('Last name kanji 全角漢字・かな・カタカナを使用してください')
    end

    it 'ユーザー本名(苗字) は、半角カタカナでは登録できないこと' do
      @user.last_name_kanji = 'ｱｲｳｴｵ'
      @user.valid?
      expect(@user.errors.full_messages).to include('Last name kanji 全角漢字・かな・カタカナを使用してください')
    end

    # first_name_kanji に関して
    it 'ユーザー本名(苗字) は、半角英字では登録できないこと' do
      @user.first_name_kanji = 'aiueo'
      @user.valid?
      expect(@user.errors.full_messages).to include('First name kanji 全角漢字・かな・カタカナを使用してください')
    end

    it 'ユーザー本名(苗字) は、半角数字では登録できないこと' do
      @user.first_name_kanji = '11111'
      @user.valid?
      expect(@user.errors.full_messages).to include('First name kanji 全角漢字・かな・カタカナを使用してください')
    end

    it 'ユーザー本名(苗字) は、半角カタカナでは登録できないこと' do
      @user.first_name_kanji = 'ｱｲｳｴｵ'
      @user.valid?
      expect(@user.errors.full_messages).to include('First name kanji 全角漢字・かな・カタカナを使用してください')
    end

    # last_name_kanaに関して
    it 'ユーザー本名の苗字のフリガナは、半角英字では登録できないこと' do
      @user.last_name_kana = 'aiueo'
      @user.valid?
      expect(@user.errors.full_messages).to include('Last name kana 全角カタカナを使用してください')
    end

    it 'ユーザー本名の苗字のフリガナは、半角数字では登録できないこと' do
      @user.last_name_kana = '11111'
      @user.valid?
      expect(@user.errors.full_messages).to include('Last name kana 全角カタカナを使用してください')
    end

    it 'ユーザー本名の苗字のフリガナは、半角カタカナでは登録できないこと' do
      @user.last_name_kana = 'ｱｲｳｴｵ'
      @user.valid?
      expect(@user.errors.full_messages).to include('Last name kana 全角カタカナを使用してください')
    end

    it 'ユーザー本名の苗字のフリガナは、全角平仮名では登録できないこと' do
      @user.last_name_kana = 'あいうえお'
      @user.valid?
      expect(@user.errors.full_messages).to include('Last name kana 全角カタカナを使用してください')
    end

    # first_name_kanaに関して
    it 'ユーザー本名の名前のフリガナは、全角（カタカナ）での入力が必須であること' do
      @user.first_name_kana = 'aiueo'
      @user.valid?
      expect(@user.errors.full_messages).to include('First name kana 全角カタカナを使用してください')
    end

    it 'ユーザー本名の名前のフリガナは半角数字では登録できないこと' do
      @user.first_name_kana = '11111'
      @user.valid?
      expect(@user.errors.full_messages).to include('First name kana 全角カタカナを使用してください')
    end

    it 'ユーザー本名の名前のフリガナは、半角カタカナでは登録できないこと' do
      @user.first_name_kana = 'ｱｲｳｴｵ'
      @user.valid?
      expect(@user.errors.full_messages).to include('First name kana 全角カタカナを使用してください')
    end

    it 'ユーザー本名の名前のフリガナは、全角ひらがなでは登録できないこと' do
      @user.first_name_kana = 'あいうえお'
      @user.valid?
      expect(@user.errors.full_messages).to include('First name kana 全角カタカナを使用してください')
    end

    it '生年月日が必須であること' do
      @user.birth_id = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Birth can't be blank")
    end
  end
end
