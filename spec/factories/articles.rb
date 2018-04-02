# == Schema Information
#
# Table name: articles
#
#  id                 :integer          not null, primary key
#  title              :string
#  content            :text
#  pub_date           :datetime
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  show               :boolean
#  image_file_name    :string
#  image_content_type :string
#  image_file_size    :integer
#  image_updated_at   :datetime
#  preview            :text
#

FactoryGirl.define do
  factory :article do
    title 'This is Test article'
    preview 'This is Test article preview'
    content 'This is Test article body'
    show true
    pub_date Time.zone.now
    image_file_name     'css3.jpg'
    image_content_type  'image/jpeg'
    image_file_size     '19789'
    image_updated_at    Time.zone.now
    tags_for_article_list 'Thing, stuff'
  end
end
