## usersテーブル

|Column              |Type    |Options                  |
|--------------------|------  |------------             |
|nickname            |string  |null: false              |
|email               |string  |unique: true, null: false|
|encrypted_password  |string  |null: false              |
|last_name_kanji     |string  |null: false              |
|first_name_kanji    |string  |null: false              |
|last_name_kana      |string  |null: false              |
|first_name_kana     |string  |null: false              |
|birth_id            |date    |null: false              |





### Association
has_many :products
has_many :records






## productsテーブル

|Column                    |Type      |Options           |
|------------              |----------|------------------|
|product_name              |string    |null: false       |
|text                      |text      |null: false       |
|price                     |integer   |null: false       |
|user                      |reference |foreign_key: true |

|category_id               |integer   |null: false       |
|product_condition_id      |integer   |null: false       |
|shipping_charge_id        |integer   |null: false       |
|shipment_source_id        |integer   |null: false       |
|estimated_shipping_date_id|integer   |null: false       |



### Association
belongs_to :user
has_one :record

## ordersテーブル

|Column      |Type      |Options           |
|------------|----------|------------------|
|user        |reference |foreign_key: true |
|product     |reference |foreign_key: true |


### Association
belongs_to :user
belongs_to :product
has_one :address

## addressesテーブル

|Column                    |Type      |Options     |
|--------------            |----------|------------|
|postal_code               |string    |null: false |
|shipment_source_id        |integer   |null: false |
|city                      |string    |null: false |
|house_number              |string    |null: false |
|building_name             |string    |            |
|phone_number              |string    |null: false |
|order                     |reference |null: false |


### Association
belongs_to :order