class BookDecorator
  delegate :id, :title, :author, :description, :book_cover, :to_model, :total_pages, to: :book
  attr_reader :book, :view_context

  def initialize(book, view_context)
    @book, @view_context = book, view_context
  end

  def cover_medium
    book.book_cover.url(:medium)
  end

  def link_to_book
    view_context.link_to title, view_context.book_path(book)
  end

  def show_book_tags
    view_context.raw book.tags_for_book_list.
        map{|t| view_context.link_to t, view_context.books_tag_path(t)}.join(', ')
  end

  def small_update_btn
     view_context.link_to view_context.edit_book_path(book), title: view_context.t(:edit), class: 'btn btn-warning' do view_context.fa_icon 'edit' end if view_context.can? :update, book
  end

  def small_destroy_btn
    view_context.link_to view_context.book_path(book), method: :delete, title: view_context.t('destroy'), data: { confirm: 'Are you sure?' }, class: 'btn btn-danger' do view_context.fa_icon 'trash' end if view_context.can? :destroy, book
  end
end
