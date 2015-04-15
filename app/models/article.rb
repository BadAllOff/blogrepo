class Article < ActiveRecord::Base
  translates :title, :content

  validates :image, :attachment_presence => true

  has_attached_file :image, :styles => { :original => "768>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  validates :title, length: { maximum: 100, minimum: 1}
  validates :content, :pub_date, presence: true
end
