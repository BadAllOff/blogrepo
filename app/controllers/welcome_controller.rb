class WelcomeController < ApplicationController
  layout 'welcome'
  def index
    get_public_articles
    @tags = Article.tag_counts_on(:tags)
  end


  def feed
    get_public_articles
    render layout: false;
  end


  def robots
    @articles = []
    @urls = [edit_user_registration_path, ckeditor_path, roles_path]
  end

  private

  def get_public_articles
    @articles = Article.all.where(show: true).order('pub_date DESC')
  end
end
