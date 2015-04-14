class AddShowToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :show, :boolean
  end
end
