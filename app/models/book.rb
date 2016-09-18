# == Schema Information
#
# Table name: books
#
#  id                      :integer          not null, primary key
#  author                  :string
#  title                   :string
#  description             :text
#  draft                   :boolean
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  book_cover_file_name    :string
#  book_cover_content_type :string
#  book_cover_file_size    :integer
#  book_cover_updated_at   :datetime
#  user_id                 :integer
#

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
