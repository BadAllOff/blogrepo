# todo Админка для управления пользователями
# todo Добваить галочку "Мы знакомы?" или  "Я Вас знаю?"
class User < ActiveRecord::Base
  belongs_to :role
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

  def admin?
    self.role.name == 'Administrator'
  end
  def author?
    self.role.name == 'Author'
  end
  def moderator?
    self.role.name == 'Moderator'
  end
  def user?
    self.role.name == 'User'
  end
  def guest?
    self.role.name == 'Guest'
  end


end
