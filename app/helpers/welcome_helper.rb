module WelcomeHelper
  def show_tags (article)
    raw article.tag_list.map{|t| link_to t, tag_path(t)}.join(', ')
  end
end
