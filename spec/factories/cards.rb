FactoryBot.define do
  factory :card do
    factory :otamesi do
      user_id { 1 }
      customer_id { "MyString" }
      card_id { "MyString" }
    end
  end
end
