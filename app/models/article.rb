class Article < ActiveRecord::Base
  has_attached_file(:image, :styles => {:original => "768>", :thumb => "100x100>"},
                    default_url: '/images/:style/missing.png',
                    storage: :s3,
                    s3_credentials: "#{Rails.root}/config/s3.yml",
                    s3_protocol: 'https',
                    s3_host_name: 's3-eu-west-1.amazonaws.com'
  )
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  validates_attachment :image, :content_type => {content_type: ['image/jpeg', 'image/gif', 'image/png']}

  translates :title, :content, :fallbacks_for_empty_translations => true

  acts_as_taggable
  validates :image, :attachment_presence => true
  validates :title, length: { maximum: 100, minimum: 1}
  validates :content, :pub_date, presence: true
end
