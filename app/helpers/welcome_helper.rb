module WelcomeHelper
  def show_article_tags (tagged)
    raw tagged.tags_for_article_list.map{|t| link_to t, articles_tag_path(t)}.join(', ')
  end

  def show_book_tags (tagged)
    raw tagged.tags_for_book_list.map{|t| link_to t, books_tag_path(t)}.join(', ')
  end
end
