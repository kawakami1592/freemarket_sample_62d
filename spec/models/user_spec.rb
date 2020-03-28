require 'rails_helper'


RSpec.describe User, type: :model do
  
  describe "#create" do

    context '保存できる' do
      it "全て入力されていれば" do
        user = build(:user)
        expect(user).to be_valid
      end
    end

    context '保存できない' do
      it "ニックネームがない" do
        user = build(:user, nickname: nil)
        user.valid?
        expect(user.errors[:nickname]).to include("を入力してください")
      end

      it "メールアドレスがない" do
        user = build(:user, email: nil)
        user.valid?
        expect(user.errors[:email]).to include("を入力してください")
      end

      it "メールアドレスが重複している" do
        user = create(:user)
        another_user = build(:user, email: user.email)
        another_user.valid?
        expect(another_user.errors[:email]).to include("はすでに存在します")
      end

      it "パスワードがない" do
        user = build(:user, password: nil)
        user.valid?
        expect(user.errors[:password]).to include("を入力してください")
      end

      it "確認用のパスワードがない" do
        user = build(:user, password_confirmation: nil)
        user.valid?
        expect(user.errors[:password_confirmation]).to include("を入力してください")
      end

      it "確認用のパスワードが６文字以下" do
        user = build(:user, password: "111111", password_confirmation: "111111")
        user.valid?
        expect(user.errors[:password_confirmation]).to include("は7文字以上で入力してください")
      end

      it "lastnameがない" do
        user = build(:user, lastname: nil)
        user.valid?
        expect(user.errors[:lastname]).to include("を入力してください")
      end

      it "firstnameがない" do
        user = build(:user, firstname: nil)
        user.valid?
        expect(user.errors[:firstname]).to include("を入力してください")
      end

      it "lastname_kanaがない" do
        user = build(:user, lastname_kana: nil)
        user.valid?
        expect(user.errors[:lastname_kana]).to include("を入力してください")
      end

      it "firstname_kanaがない" do
        user = build(:user, firstname_kana: nil)
        user.valid?
        expect(user.errors[:firstname_kana]).to include("を入力してください")
      end

      it "生年月日の年がない" do
        user = build(:user, birthyear_id: nil)
        user.valid?
        expect(user.errors[:birthyear_id]).to include("を入力してください")
      end

      it "生年月日の月がない" do
        user = build(:user, birthmonth_id: nil)
        user.valid?
        expect(user.errors[:birthmonth_id]).to include("を入力してください")
      end

      it "生年月日の日がない" do
        user = build(:user, birthday_id: nil)
        user.valid?
        expect(user.errors[:birthday_id]).to include("を入力してください")
      end

      it "郵便番号がない" do
        user = build(:user, zipcode: nil)
        user.valid?
        expect(user.errors[:zipcode]).to include("を入力してください")
      end

      it "都道府県がない" do
        user = build(:user, pref_id: nil)
        user.valid?
        expect(user.errors[:pref_id]).to include("を入力してください")
      end

      it "市町村がない" do
        user = build(:user, city: nil)
        user.valid?
        expect(user.errors[:city]).to include("を入力してください")
      end

      it "番地がない" do
        user = build(:user, address: nil)
        user.valid?
        expect(user.errors[:address]).to include("を入力してください")
      end

      it "lastnameが半角で入力されている" do
        user = build(:user, lastname: "ka")
        user.valid?
        expect(user.errors[:lastname]).to include("は不正な値です")
      end

      it "firstnameが半角で入力されている" do
        user = build(:user, firstname: "ka")
        user.valid?
        expect(user.errors[:firstname]).to include("は不正な値です")
      end

      it "lastname_kanaが半角で入力されている" do
        user = build(:user, lastname_kana: "ka")
        user.valid?
        expect(user.errors[:lastname_kana]).to include("は不正な値です")
      end

      it "firstnam_kanaeが半角で入力されている" do
        user = build(:user, firstname_kana: "ka")
        user.valid?
        expect(user.errors[:firstname_kana]).to include("は不正な値です")
      end

    end
  end
end