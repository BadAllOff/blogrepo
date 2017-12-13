class CommentsController < ApplicationController
  # todo добавить показ комментариев только после модерации
  before_action :authenticate_user!, only: [:create, :update, :destroy]
  before_action :load_commentable
  load_and_authorize_resource

  def create
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

  def update
    if @comment.update(comment_params)
      respond_to do |format|
        format.html { redirect_to @commentable, notice: t('.comment_updated') }
      end
    else
      format.html { render :edit }
    end
  end

  def destroy
    @comment.destroy
    respond_with(@commentable, notice: t('.comment_destroyed'))
  end

  private

  def load_commentable
    resource, id = request.path.split('/')[2, 3]
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
