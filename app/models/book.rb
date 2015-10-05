class Book < ActiveRecord::Base
  has_many :comments, as: :commentable

  acts_as_taggable
  acts_as_taggable_on :tags_for_books
  translates :title, :author, :description, :fallbacks_for_empty_translations => true
  has_attached_file :book_cover, :styles => { :medium => "320x470#"}, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :book_cover, :content_type => /\Aimage\/.*\Z/
  validates :book_cover, :attachment_presence => true

  validates :title, length: { maximum: 160, minimum: 1}
  validates :author, :description, presence: true
end
