## usersテーブル

|Column   |Type  |Options     |
|---------|------|------------|
|nickname |string|unique: true|
|email    |string|unique: true|
|password |string|null: false |



### Association
has_many :products
has_many :records
has_one :address





## productsテーブル

|Column      |Type      |Options           |
|------------|----------|------------------|
|product_name|string    |null: false       |
|text        |text      |                  |
|image       |ActiveStorageで紐付け         |
|price       |integer   |null: false       |
|user_id     |reference | foreign_key: true|


### Association
belongs_to :user
has_one :record

## recordsテーブル

|Column      |Type      |Options           |
|------------|----------|------------------|
|buyer       |string    |null: false       |
|sold_product|string    |null: false       |
|user_id     |reference |foreign_key: true |
|product_id  |reference |foreign_key: true |
|address_id  |reference |foreign_key: true |

### Association
belongs_to :user
belongs_to :product
belongs_to :address

## addressesテーブル

|Column        |Type      |Options     |
|--------------|----------|------------|
|postal_code   |integer   |null: false |
|prefecture    |string    |null: false |
|city          |string    |null: false |
|house_number  |integer   |null: false |
|building_name |string    |null: false |
|phone_number  |integer   |null: false |
|user_id       |reference |null: false |


### Association
belongs_to :user
belongs_to :record