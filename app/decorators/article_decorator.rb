class ArticleDecorator
  delegate :id, :title, :to_model, :total_pages, to: :article
  attr_reader :article, :view_context

  def initialize(article, view_context)
    @article, @view_context = article, view_context
  end

  def published_at
    view_context.time_ago_in_words(article.pub_date)
  end

  def title_link
    view_context.link_to title, view_context.article_path(article)
  end

  def show_article_tags
    view_context.raw article.tags_for_article_list.
        map{|t| view_context.link_to t, view_context.articles_tag_path(t)}.join(', ')
  end

  def image_original
    article.image.url(:original)
  end

  def content
    article.content.html_safe if article.content
  end

  def preview
    view_context.truncate(view_context.strip_tags(article.preview), length: 170, separator: ' ') if article.preview
  end

  def small_update_btn
    view_context.link_to view_context.edit_article_path(article), title: view_context.t('edit'), class: 'btn btn-warning' do view_context.fa_icon 'edit' end if view_context.can? :update, article
  end

  def small_destroy_btn
    view_context.link_to view_context.article_path(article), method: :delete, title: view_context.t('destroy'), data: { confirm: 'Are you sure?' }, class: 'btn btn-danger' do view_context.fa_icon 'trash' end if view_context.can? :destroy, article
  end
end