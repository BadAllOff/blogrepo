class CommentsController < ApplicationController
  # todo create methods edit destroy update for each users there own comments +moderator
  before_action :authenticate_user!, only: [ :new, :create, :update, :destroy, :edit, ]
  before_action :load_commentable # before_filter is just a new syntax for before_action
  def index
    @comments = @commentable.comments
  end

  def new
    @comment = @commentable.comments.new # todo redirect на нужные страницы
  end

  def create
    # todo добавить показ только после модерации
    @comment = @commentable.comments.new(comment_params)
    @comment.commentator_id = current_user.id
    @comment.commentator_name = current_user.username
    @comment.content = ActionView::Base.full_sanitizer.sanitize(comment_params[:content])

    # @comment
    if @comment.save
      redirect_to @commentable, notice: t('.comment_created')
    else
      render :new
    end
  end

  def edit # todo only for admin, let other people think before comment - at least checking grammar rules in message will make them more meaningful
    redirect_to root_path
  end

  def update
    redirect_to root_path
  end

  def destroy
    redirect_to root_path
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
