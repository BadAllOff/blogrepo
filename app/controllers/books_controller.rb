class BooksController < ApplicationController
  # TODO: Добавить счётчик комментариев и просмотров к книгам.
  # TODO: rename uploaded images
  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy]
  before_action :load_tags, only: [:show, :index]
  load_and_authorize_resource

  respond_to :html

  def index
    @books_decorator = load_books.map { |book| BookDecorator.new(book, view_context) }
  end

  def show
    @commentable = @book
    @comments = @commentable.comments.order('created_at DESC')
    @comment = Comment.new
    @book_decorator = BookDecorator.new(@commentable, view_context)
    respond_with(@book_decorator)
  end

  def new
    @book = Book.new
    respond_with(@book)
  end

  def edit; end

  def create
    @book = Book.new(book_params)
    @book.tags_for_book_list.add(params[:tags_for_book_list], parse: true)
    @book.save
    respond_with(@book)
  end

  def update
    @book.update(book_params)
    respond_with(@book)
  end

  def destroy
    @book.destroy
    respond_with(@book)
  end

  private

  def load_tags
    @tags = Book.tag_counts_on :tags_for_books
  end

  def book_params
    params.require(:book).permit(:author, :title, :description, :draft, :book_cover, :tags_for_book_list)
  end

  def load_books
    if user_signed_in?
      return @books = Book.tagged_with(params[:tag]).order('updated_at DESC') if params[:tag]
      @books = Book.all.order('updated_at DESC')
    else
      return @books = Book.tagged_with(params[:tag]).where(draft: false).order('updated_at DESC')if params[:tag]
      @books = Book.all.where(draft: false).order('updated_at DESC')
    end
  end
end
