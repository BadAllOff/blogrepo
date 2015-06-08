class AddCommentatorIdAndCommentatorNameToComments < ActiveRecord::Migration
  def change
    add_column :comments, :commentator_id, :integer
    add_column :comments, :commentator_name, :string
  end
end
