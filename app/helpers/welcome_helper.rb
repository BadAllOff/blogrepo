module WelcomeHelper
  def show_article_tags (tagged)
    raw tagged.tag_list.map{|t| link_to t, articles_tag_path(t)}.join(', ')
  end

  def show_book_tags (tagged)
    raw tagged.tag_list.map{|t| link_to t, books_tag_path(t)}.join(', ')
  end
end
