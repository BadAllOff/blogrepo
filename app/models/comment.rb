# == Schema Information
#
# Table name: comments
#
#  id               :integer          not null, primary key
#  content          :text
#  commentable_id   :integer
#  commentable_type :string
#  created_at       :datetime
#  updated_at       :datetime
#  commentator_id   :integer
#  commentator_name :string
#

class Comment < ActiveRecord::Base
  belongs_to :commentable, polymorphic: true
  validates :content, presence: true
end
