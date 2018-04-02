# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime
#  updated_at             :datetime
#  username               :string
#  role_id                :integer          default(2)
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#

class User < ActiveRecord::Base
  belongs_to :role
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # :registerable, :recoverable,
  devise :database_authenticatable, :rememberable, :trackable, :validatable, :registerable, :confirmable, :recoverable
  validates :username,
            length: { maximum: 40 },
            uniqueness: { case_sensitive: false },
            format: { with: /\A[а-яА-ЯёЁa-zA-Z0-9]+\Z/,
                      message: :bad_username
                    },
            presence: true

  def admin?
    role.name == 'Administrator'
  end

  def author?
    role.name == 'Author'
  end

  def moderator?
    role.name == 'Moderator'
  end

  def user?
    role.name == 'User'
  end

  def guest?
    role.name == 'Guest'
  end
end
