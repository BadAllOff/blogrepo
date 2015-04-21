class AddTranslationToArticle < ActiveRecord::Migration
  def self.up
    Article.add_translation_fields! :preview => {:type => :text, :null => false, :default => 'No translation... yet!'}
  end

  def self.down
    remove_column :article_translations, :preview
  end
end
