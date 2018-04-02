class ArticlesController < ApplicationController
  # TODO: Добавить счётчик комментариев и просмотров к статьям
  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy]
  before_action :load_tags, only: [:index]

  respond_to :html

  load_and_authorize_resource
  def index
    @article_decorators = load_articles.map { |article| ArticleDecorator.new(article, view_context) }
  end

  def show
    @comments = @article.comments.order('created_at DESC')
    @comment = Comment.new
    @article_decorator = ArticleDecorator.new(@article, view_context)
  end

  def new
    respond_with(@article = Article.new)
  end

  def edit; end

  def create
    @article = Article.new(article_params)
    @article.tags_for_article_list.add(params[:tags_for_article_list], parse: true)
    @article.save
    respond_with(@article)
  end

  def update # TODO: проверка параметра в пост запросе :show - только для админа
    @article.tags_for_article_list.add(params[:tags_for_article_list], parse: true)
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to @article, notice: t('.article_updated') }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, notice: t('.article_destroyed') }
      format.json { head :no_content }
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :preview, :content, :pub_date, :show, :image, :tags_for_article_list)
  end

  def load_tags
    @tags = Article.tag_counts_on :tags_for_articles
  end

  def load_articles
    if user_signed_in?
      return @articles = Article.tagged_with(params[:tag]).order('pub_date DESC').page(params[:page]).per(5) if params[:tag]
      @articles = Article.order('pub_date DESC').page(params[:page]).per(5)
    else
      return @articles = Article.tagged_with(params[:tag]).where(show: true).order('pub_date DESC').page(params[:page]).per(5) if params[:tag]
      @articles = Article.where(show: true).order('pub_date DESC').page(params[:page]).per(5)
    end
  end
end
