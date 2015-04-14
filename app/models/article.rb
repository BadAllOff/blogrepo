class Article < ActiveRecord::Base
  validates :title, length: { maximum: 100, minimum: 1}
  validates :content, :pub_date, presence: true
end
