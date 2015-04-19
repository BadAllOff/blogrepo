class WelcomeController < ApplicationController
  def index
    @articles = Article.all.where(show: true).order('pub_date DESC')
    @tags = Article.tag_counts_on(:tags)
  end
end
