class TranslateArticles < ActiveRecord::Migration
  def self.up
    Article.create_translation_table! :title => :string,
                                   :content => {:type => :text, :null => false, :default => 'No content ... yet!'}
  end

  def self.down
    Article.drop_translation_table! :migrate_data => true
  end
end
