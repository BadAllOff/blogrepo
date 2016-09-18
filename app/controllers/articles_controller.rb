class ArticlesController < ApplicationController
  # TODO Добавить счётчик комментариев и просмотров к статьям
  before_action :authenticate_user!, only: [ :new, :edit, :create, :update, :destroy]
  before_action :load_tags, only: [:index]

  respond_to :html

  load_and_authorize_resource
  # GET /articles
  # GET /articles.json
  def index
    load_articles
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
    # @commentable = @article
    @comments = @article.comments.order('created_at DESC')
    @comment = Comment.new
  end

  # GET /articles/new
  def new
    respond_with(@article = Article.new)
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = Article.new(article_params)
    @article.tags_for_article_list.add(params[:tags_for_article_list], parse: true)
    @article.save
    respond_with(@article)
    #
    # respond_to do |format|
    #   if @article.save
    #     format.html { redirect_to @article, notice: t('.article_created') }
    #     format.json { render :show, status: :created, location: @article }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @article.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update #todo проверка параметра в пост запросе :show - только для админа
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

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, notice: t('.article_destroyed') }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    # def set_article
    #   @article = Article.find(params[:id])
    # end

    # Never trust parameters from the scary internet, only allow the white list through.
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
