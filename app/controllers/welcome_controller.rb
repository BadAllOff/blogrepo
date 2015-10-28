class WelcomeController < ApplicationController
  layout 'welcome', except: [:sitemap, :robots, :feed]
  def index
    get_public_articles
    @tags = Article.tag_counts_on(:tags)
  end


  def feed
    get_public_articles
  end


  def robots
    @articles = []
    @urls = [edit_user_registration_path, ckeditor_path, roles_path]
  end


  def sitemap
    get_public_articles
    respond_to do |format|
      format.xml { render file: 'public/sitemaps/sitemap.xml' }
      format.html { redirect_to root_url }
    end
  end
  private

  def get_public_articles
    @articles = Article.where(show: true).order('pub_date DESC').page(params[:page]).per(10)
  end
end
