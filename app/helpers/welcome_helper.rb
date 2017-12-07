module WelcomeHelper
  def show_book_tags(tagged)
    raw tagged.tags_for_book_list.map{|t| link_to t, books_tag_path(t)}.join(', ')
  end
end
