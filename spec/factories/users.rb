FactoryBot.define do
  factory :user do
    nickname              { "yamada" }
    email                 {Faker::Internet.free_email}
    password              { "abcd1234" }
    password_confirmation { password }
    last_name_kanji       { "太郎" }
    first_name_kanji      { "山田" }
    last_name_kana        { "タロウ" }
    first_name_kana       { "ヤマダ" }
    birth_id              { "2020-01-01" }
  end
end