class CreateRoles < ActiveRecord::Migration
  def self.up
    create_table :roles do |t|
      t.string :name
      t.string :description

      t.timestamps null: false
    end

    Role.create(id: 1, name: 'Administrator', description: 'Administrator have all the rights.')
    Role.create(id: 2, name: 'User', description: 'User can leave a comments, edit his own comments, but not delete them.')
    Role.create(id: 3, name: 'Moderator', description: 'Moderator have rights to manage comments and articles, but not delete them.')
    Role.create(id: 4, name: 'Author', description: 'Author can create articles and edit his own\'s. But not delete them')
    Role.create(id: 5, name: 'Guest', description: 'Guest must act like guest, be polite and modest. Can only be a observer.')
  end

  def self.down
    drop_table :roles
  end
end
