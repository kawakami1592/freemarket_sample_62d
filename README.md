# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version
  2.5.1
* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

# freemarket_sample_62d DB設計
## usersテーブル
|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false|
|email|string|null: false,unique: true|
|password|string|null: false|
|encrypted_password|string|null: false|
|lastname|string|null: false|
|firstname|string|null: false|
|zipcode|string|null: false|
|pref|string|null: false|
|city|string|null: false|
|address|string|null: false|
|buildingname|string||
|phone|string||
|lastname_kana|string|null: false|
|firstname_kana|string|null: false|
|birthyear|string|null: false|
|birthmonth|string|null: false|
|birthday|string|null: false|

### Association
- has_many :items

## cardsテーブル
|Column|Type|Options|
|------|----|-------|
|number|integer|null: false,|
|customer_id|integer|null: false,foreign_key: true|
|user_id|integer|null: false, foreign_key: true|
### Association
- belongs_to :user

## itemsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|text|text|null: false|
|form|string|null: false|
|days|string|null: false|
|price|integer|null: false|
|delflg|tinyint|null: false|
|boughtflg|tinyint|null: false|
|status_id|integer|null: false, foreign_key: true|
|deriverycost_id|integer|null: false, foreign_key: true|


### Association
- belongs_to :user
- belongs_to :category
- belongs_to :status
- has_many  :images,
- has_many  :categorys,  through:  :categorys_items

## categoryテーブル
Column|Type|Options|
|------|----|-------|
|status|string|null: false|

### Association
- has_many  :itemss,  through:  :categorys_items

## imagesテーブル
Column|Type|Options|
|------|----|-------|
|image|blob|null: false|
|item_id|int|null: false,foreign_key: true|

### Association
- belong_to :item

## statusテーブル
Column|Type|Options|
|------|----|-------|
|status|string|null: false|

### Association
- has_many :items

## deiverycostsテーブル
Column|Type|Options|
|------|----|-------|
|payer|string|null: false|

### Association
- has_many :items