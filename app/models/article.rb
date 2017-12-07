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

class Article < ActiveRecord::Base
  has_many :comments, as: :commentable, inverse_of: :commentable
  # PAPERCLIP_STORAGE_OPTS defined in config/enviroment/development\production.rb
  has_attached_file :image, PAPERCLIP_STORAGE_OPTS

  acts_as_taggable # act as taggable не должно быть точек
  acts_as_taggable_on :tags_for_articles
  translates :title, :content, :preview, fallbacks_for_empty_translations: true
  accepts_nested_attributes_for :translations, allow_destroy: true

  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  validates_attachment :image, content_type: { content_type: ['image/jpeg', 'image/gif', 'image/png'] }
  validates :image, attachment_presence: true
  validates :title, length: { maximum: 140, minimum: 1 }
  validates :content, :pub_date, :preview, :tags_for_article_list, presence: true
end
