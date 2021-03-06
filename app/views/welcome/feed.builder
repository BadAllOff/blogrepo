xml.instruct!
xml.rss version: '2.0', 'xmlns:atom' => 'http://www.w3.org/2005/Atom' do
  xml.channel do
    xml.title t('welcome.blog_header.blog_title')
    xml.description t('welcome.blog_header.blog-description')
    xml.link root_url
    xml.language I18n.locale.to_s
    xml.tag! 'atom:link', rel: 'self', type: 'application/rss+xml', href: 'home/rss'

    for article in @articles
      xml.item do
        xml.title article.title
        xml.link article_url(article)
        xml.pubDate(article.created_at.rfc2822)
        xml.guid article_url(article)
        xml.description(h(strip_tags(article.content[0..160])))
      end
    end
  end
end
