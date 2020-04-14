FactoryBot.define do
  factory :user do
    password = Faker::Internet.password(min_length: 7)
    nickname {"まーたろー"}
    lastname {"真"} 
    firstname {"太郎"}
    lastname_kana {"ま"}
    firstname_kana {"たろう"}
    zipcode {"1111111"}
    pref_id {"1"}
    city {"青梅市"}
    address {"1-2-3"}
    buildingname {"マンション"}
    birthyear_id {"20"}
    birthmonth_id {"5"}
    birthday_id {"23"}

    email {Faker::Internet.free_email}
    password {password}
    password_confirmation {password}
  end
end