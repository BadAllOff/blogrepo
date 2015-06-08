class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # :registerable, :recoverable,
  devise :database_authenticatable, :rememberable, :trackable, :validatable #, :registerable
  validates :username,
            length: {maximum: 40 },
            uniqueness: { case_sensitive: false },
            format: { with: /\A[а-яА-ЯёЁa-zA-Z0-9]+\Z/,
                      message: :bad_username
                    },
            presence: true
end
