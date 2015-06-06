class BooksController < ApplicationController
  before_action :authenticate_user!, only: [ :new, :edit, :create, :update, :destroy]
  before_action :set_book, only: [:show, :edit, :update, :destroy]
  before_action :get_genres, only: [:show, :index]

  respond_to :html

  def index
    if user_signed_in?
      return @books = Book.tagged_with(params[:tag]).order('updated_at DESC') if params[:tag]
      @books = Book.all.order('updated_at DESC')
    else
      return @books = Book.tagged_with(params[:tag]).where(draft: false).order('updated_at DESC')if params[:tag]
      @books = Book.all.where(draft: false).order('updated_at DESC')
    end
    respond_with(@books)
  end

  def show
    @commentable = @book
    @comments = @commentable.comments
    @comment = Comment.new
    respond_with(@book)
  end

  def new
    @book = Book.new
    respond_with(@book)
  end

  def edit
  end

  def create
    @book = Book.new(book_params)
    @book.tag_list.add(params[:tag_list], parse: true)
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
    def get_genres
      @tags = Book.tag_counts_on(:genres)
    end

    def set_book
      @book = Book.find(params[:id])
    end

    def book_params
      params.require(:book).permit(:author, :title, :description, :draft, :book_cover, :tag_list)
    end
end
