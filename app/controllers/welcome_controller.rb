class WelcomeController < ApplicationController
  def index
    @articles = Article.all.order('pub_date DESC')
  end
end
