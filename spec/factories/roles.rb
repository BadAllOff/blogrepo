# == Schema Information
#
# Table name: roles
#
#  id          :integer          not null, primary key
#  name        :string
#  description :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryGirl.define do
  factory :admin_role, class: 'Role' do
    id 1
    name 'Administrator'
    description 'Administrator have all the rights.'
  end

  factory :user_role, class: 'Role' do
    id 2
    name 'User'
    description 'User can leave a comments, edit his own comments, but not delete them.'
  end

  factory :guest_role, class: 'Role' do
    id 5
    name 'Guest'
    description 'Guest must act like guest, be polite and modest. Can only be a observer.'
  end
end
