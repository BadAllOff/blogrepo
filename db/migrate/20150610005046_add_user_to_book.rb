class AddUserToBook < ActiveRecord::Migration
  def change
    add_reference :books, :user, index: true, foreign_key: true
  end

  def self.down
    remove_reference(:books, :user, { index: true, foreign_key: true })
  end
end
