class TranslateBooks < ActiveRecord::Migration
  def self.up
    Book.create_translation_table!({
                                       :author      => :string,
                                       :title       => :string,
                                       :description => :text
                                   }, {
                                       :migrate_data => true
                                   })
  end

  def self.down
    Book.drop_translation_table! :migrate_data => true
  end
end
