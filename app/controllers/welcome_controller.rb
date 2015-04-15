class WelcomeController < ApplicationController
  def index
    @articles = Article.all.where(show: true).order('pub_date DESC')
  end
end
