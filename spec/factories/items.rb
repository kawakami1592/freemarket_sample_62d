FactoryBot.define do
  factory :item do
    name {"hoge"}
    text {Faker::Lorem.sentence}
    condition_id {1}
    deliverycost_id {1}
    pref_id {13}
    delivery_days_id {1}
    price {"9999"}
    boughtflg_id {1}
    user
    category

    trait :images do
      after(:build) do |item|
        File.open("#{Rails.root}/public/images/Unknown.jpeg") do |f|
          item.images.attach(io: f, filename: "Unknown.jpeg", content_type: 'image/jpeg')
        end
      end
    end
    
  end
end
