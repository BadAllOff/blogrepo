class AddRoleToUser < ActiveRecord::Migration
  def self.up
    add_reference :users, :role, index: true, foreign_key: true, default: 2
  end

  def self.down
    remove_reference(:users, :role, {:index=>true, :foreign_key=>true, :default=>5})
  end
end
