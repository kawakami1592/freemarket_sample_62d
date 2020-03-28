require 'rails_helper'

RSpec.describe Item, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
  describe "#create" do
    context '保存できる' do
      it "全て入力されていれば" do
        item = build(:item)
        expect(item).to be_valid
      end
    end
  end
end
