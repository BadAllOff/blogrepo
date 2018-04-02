class CreateArticles < ActiveRecord::Migration
  def up
    create_table :articles do |t|
      t.string :title
      t.text :content
      t.datetime :pub_date

      t.timestamps null: false
    end
  end

  def down
    drop_table :articles
  end
end
