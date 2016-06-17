class Article < ActiveRecord::Base
  has_many :comments, as: :commentable

  acts_as_taggable # act as taggable не должно быть точек
  acts_as_taggable_on :tags_for_articles
  translates :title, :content, :preview, :fallbacks_for_empty_translations => true

  # PAPERCLIP_STORAGE_OPTS defined in config/enviroment/development\production.rb
  has_attached_file :image, PAPERCLIP_STORAGE_OPTS

  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  validates_attachment :image, :content_type => {content_type: ['image/jpeg', 'image/gif', 'image/png']}
  validates :image, :attachment_presence => true

  validates :title, length: { maximum: 140, minimum: 1}
  validates :content, :pub_date, :preview, :tags_for_article_list, presence: true
end
