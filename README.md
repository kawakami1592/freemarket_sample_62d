# アプリケーション情報

# アプリケーション概要
- フリーマーケットのアプリケーションを作成しました。
# 接続先情報
- URL http://3.115.38.38/
### ID/Pass
- ID: admin
- Pass: 2222
## テスト用アカウント等
＊Facebook/Googleでのログインは実装しておりません
### 購入者用
- メールアドレス: hoge@hoge
- パスワード: 11111111
- 購入用カード情報
- 番号：4242424242424242
- 期限：12/20
- セキュリティコード：123
### 出品者用
- メールアドレス名: fuga@fuga
- パスワード: 1234567

# 開発状況
## 開発環境
- Ruby/Ruby on Rails/MySQL/Github/AWS/Visual Studio Code
- 開発期間と平均作業時間
- 開発期間：約８週間
- 1日あたりの平均作業時間：4時間
## 開発体制
- 人数：5人
- アジャイル型開発（スクラム）
- Trelloによるタスク管理

# 動作確認方法
Chromeの最新版を利用してアクセスしてください。
ただしデプロイ等で接続できないタイミングもございます。その際は少し時間をおいてから接続ください。
接続先およびログイン情報については、上記の通りです。
同時に複数の方がログインしている場合に、ログインできない可能性がございます。

出品者用テストアカウントでログイン→トップページから出品ボタン押下→商品情報入力→商品出品
購入者用テストアカウントでログイン→トップページから商品選択→商品詳細ページから商品購入ページ→商品購入
確認後、ログアウト処理をお願いします。



# 紹介
![screencapture-3-115-38-38-2020-06-24-17_20_53](https://user-images.githubusercontent.com/57590363/85522904-349c2800-b641-11ea-9248-47d79e0514f5.png)

![screencapture-3-115-38-38-items-new-2020-06-24-17_40_43](https://user-images.githubusercontent.com/57590363/85523496-02d79100-b642-11ea-872f-53a38c0cdfa2.png)

![screencapture-3-115-38-38-items-11-2020-06-24-17_43_24](https://user-images.githubusercontent.com/57590363/85523678-43370f00-b642-11ea-8c7a-8a25b76818a3.png)




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
|phone|string||
|birthyear_id|bigint|null: false|
|birthmonth_id|bigint|null: false|
|birthday_id|bigint|null: false|

### Association
- belongs_to_active_hash :birthyear_id
- belongs_to_active_hash :birthmonth_id
- belongs_to_active_hash :birthday_id
- has_many :items
- has_one :card
- has_one :address


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
|pref_id|bigint|null: false, foreign_key: true|

### Association
- belongs_to :user
- belongs_to_active_hash :deriverycost
- belongs_to_active_hash :delivery_days
- belongs_to_active_hash :condition
- belongs_to_active_hash :boughtflg
- belongs_to_active_hash :pref
- belongs_to :category
- belongs_to :address, through: :users
- has_many_attached  :images


## categoryテーブル
Column|Type|Options|
|------|----|-------|
|status|string|null: false|

### Association
- has_many  :items
- has_ancestry


## addressテーブル
|Column|Type|Options|
|------|----|-------|
|zipcode|string|null: false|
|pref_id|bigint|null: false|
|city|string|null: false|
|address|string|null: false|
|buildingname|string||
|user_id|bigint|null: false, foreign_key: true|

### Association
- belongs_to :user
- belongs_to_active_hash :pref
- has_many  :items, through: :users


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