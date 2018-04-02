# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime
#  updated_at             :datetime
#  username               :string
#  role_id                :integer          default(2)
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#

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
    confirmed_at          Time.zone.now

    factory :admin_user do
      role_id 1
    end
  end
end
