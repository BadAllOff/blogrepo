FactoryGirl.define do

  sequence :email do |n|
    "user#{n}@test.com"
  end

  sequence :username do |n|
    "username#{n}"
  end

  factory :user do
    username
    email
    password '123456789'
    password_confirmation '123456789'
    confirmed_at          Time.now

    factory :admin_user do
      role_id 1
    end

  end

end