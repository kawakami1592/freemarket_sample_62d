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
## userテーブル
|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false|
|email|string|null: false,unique: true|
|encrypted_password|string|null: false|
|lastname|string|null: false|
|firstname|string|null: false|
|lastname_kana|string|null: false|
|firstname_kana|string|null: false|
|zipcode|string|null: false|
|pref_id|bigint|null: false|
|city|string|null: false|
|address|string|null: false|
|buildingname|string||
|phone|string||
|lastname_kana|string|null: false|
|firstname_kana|string|null: false|
|birthyear_id|bigint|null: false|
|birthmonth_id|bigint|null: false|
|birthday_id|bigint|null: false|

### Association
- has_many :items
- has_one :card


## cardテーブル
|Column|Type|Options|
|------|----|-------|
|number|string|null: false,|
|customer_id|string|null: false|
|user_id|bigint|null: false, foreign_key: true|

### Association
- belongs_to :user


## itemテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|text|text|null: false|
|price|integer|null: false|
|user_id|bigint|null: false, foreign_key: true|
|category_id|bigint|null: false, foreign_key: true|
|condition_id|bigint|null: false, foreign_key: true|
|deriverycost_id|integer|null: false, foreign_key: true|
|delivery_days_id|bigint|null: false, foreign_key: true|
|boughtflg_id|bigint|null: false, foreign_key: true|

### Association
- belongs_to :user
- belongs_to_active_hash :deriverycost
- belongs_to_active_hash :status
- has_many_attached  :images
- has_many  :categories,  through:  :categorys_items


## categoryテーブル
Column|Type|Options|
|------|----|-------|
|status|string|null: false|

### Association
- has_many  :items,  through:  :categories_items


### active hash
|Column|Type|Options|
|------|----|-------|
|pref|string|null: false|
|birthyear|string|null: false|
|birthmonth|string|null: false|
|birthday|string|null: false|
|conditions|string|null: false|
|deliverycost|string|null: false|
|delivery_days|string|null: false|


### active storage
|Column|Type|Options|
|------|----|-------|
|image|blob|null: false|