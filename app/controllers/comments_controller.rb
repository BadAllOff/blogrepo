class CommentsController < ApplicationController
  before_filter :load_commentable
  def index
    @comments = @commentable.comments
  end

  def new
    @comment = @commentable.comments.new # todo redirect на нужные страницы
  end

  def create
    @comment = @commentable.comments.new(comment_params)
    if @comment.save
      redirect_to @commentable, notice: 'Comment created' #TODO localize
    else
      render :new
    end
  end

  private

  def load_commentable
    resource, id = request.path.split('/')[2,3]
    @commentable = resource.singularize.classify.constantize.find(id)
  end
  # Ещё один метод если пути настроены по своему.
  # def load_commentable
  #   klass = [Article, Book].detect { |c| params["#{c.name.underscore}_id"]}
  #   @commentable = klass.find(params["#{klass.name.underscore}_id"])
  # end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
