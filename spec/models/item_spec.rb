require 'rails_helper'

RSpec.describe Item, type: :model do
  describe '#create' do
    let(:user) { create(:user) }
    let(:category) { create(:category) }
    
    context '保存できる' do
      it '全て入力されていれば' do
        item = build(:item,:images, user: user, category: category)
        expect(item).to be_valid
      end
      it 'priceが300以上'do
        item = build(:item,:images, user: user, category: category, price: 300)
        expect(item).to be_valid
      end
      it 'priceが9999999以下'do
        item = build(:item,:images, user: user, category: category, price: 9999999)
        expect(item).to be_valid
      end
    end

    context '保存できない' do
      it '画像がない'do
        item = build(:item, user: user, category: category)
        # let(:item_nonimage) { build(:item, :nonimage) }
        item.valid?
        expect(item.errors[:image]).to include('画像がありません')
      end
      it '画像が多い'do
        item = build(:item, user: user, category: category)
        11.times do
          File.open("#{Rails.root}/public/images/Unknown.jpeg") do |f|
            item.images.attach(io: f, filename: "Unknown.jpeg", content_type: 'image/jpeg')
          end
        end
        item.valid?
        expect(item.errors[:image]).to include('10枚まで投稿できます')
      end
      it 'nameがない'do
        item = build(:item,:images, user: user, category: category, name: nil)
        item.valid?
        expect(item.errors[:name]).to include('を入力してください')
      end
      it 'textがない'do
        item = build(:item,:images, user: user, category: category, text: nil)
        item.valid?
        expect(item.errors[:text]).to include('を入力してください')
      end
      it 'category_idがない'do
        item = build(:item,:images, user: user, category_id: nil)
        item.valid?
        expect(item.errors[:category_id]).to include('を入力してください')
      end
      it 'condition_idがない'do
        item = build(:item,:images, user: user, category: category, condition_id: nil)
        item.valid?
        expect(item.errors[:condition_id]).to include('を入力してください')
      end
      it 'deliverycost_idがない'do
        item = build(:item,:images, user: user, category: category, deliverycost_id: nil)
        item.valid?
        expect(item.errors[:deliverycost_id]).to include('を入力してください')
      end
      it 'pref_idがない'do
        item = build(:item,:images, user: user, category: category, pref_id: nil)
        item.valid?
        expect(item.errors[:pref_id]).to include('を入力してください')
      end
      it 'delivery_days_idがない'do
        item = build(:item,:images, user: user, category: category, delivery_days_id: nil)
        item.valid?
        expect(item.errors[:delivery_days_id]).to include('を入力してください')
      end
      it 'boughtflg_idがない'do
        item = build(:item,:images, user: user, category: category, boughtflg_id: nil)
        item.valid?
        expect(item.errors[:boughtflg_id]).to include('を入力してください')
      end
      it 'user_idがない'do
        item = build(:item,:images, user_id: nil, category: category)
        item.valid?
        expect(item.errors[:user_id]).to include('を入力してください')
      end
      it 'priceが300未満'do
        item = build(:item,:images, user: user, category: category, price: 299)
        item.valid?
        expect(item.errors[:price]).to include('は300以上の値にしてください')
      end
      it 'priceが9999999以上'do
        item = build(:item,:images, user: user, category: category, price: 10000000)
        item.valid?
        expect(item.errors[:price]).to include('は9999999以下の値にしてください')
      end
    end
  end
end

