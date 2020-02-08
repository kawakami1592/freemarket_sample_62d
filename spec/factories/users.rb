FactoryBot.define do
  factory :user do
    password = Faker::Internet.password(min_length: 7)
    nickname {"まーたろー"}
    lastname {"真"} 
    firstname {"太郎"}
    lastname_kana {"ま"}
    firstname_kana {"たろう"}
    zipcode {"1111111"}
    pref {"東京都"}
    city {"青梅市"}
    address {"1-2-3"}
    buildingname {"マンション"}
    birthyear {"2000"}
    birthmonth {"12"}
    birthday {"23"}

    email {Faker::Internet.free_email}
    password {password}
    password_confirmation {password}
  end
end