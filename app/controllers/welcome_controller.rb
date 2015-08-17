class WelcomeController < ApplicationController
  layout 'welcome'
  def index
    get_articles
    @tags = Article.tag_counts_on(:tags)
  end



  def feed
    get_articles
    render layout: false;
  end

  private

  def get_articles
    @articles = Article.all.where(show: true).order('pub_date DESC')
  end
end
