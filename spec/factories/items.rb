FactoryBot.define do
  factory :item do
    name {"hoge"}
    text {Faker::Lorem.sentence}
    user_id {"1"}
    category_id {"123"}
    condition_id {"1"}
    deliverycost_id {"1"}
    pref_id {"13"}
    delivery_days_id {"1"}
    price {"9999"}
    boughtflg_id {"1"}

    #File.open("#{Rails.root}/public/images/Unknown.jpeg")
    
    # after(:create) do |hoge|
    #   File.open("#{Rails.root}/public/images/Unknown.jpeg") do |f|
    #     hoge.image.attach(io: f, filename: "#{hoge.id}.png", content_type: 'image/png')
    #   end
    # end
  end
end
