require_relative '../../acceptance/acceptance_helper'

feature 'Update Book', '
        I want be able to update book
  ' do

  given!(:admin_user) { create(:admin_user) }
  given!(:book)    { create(:book) }

  describe 'Authenticated user' do
    before do
      sign_in(admin_user)
      visit book_path(book, locale: 'en')
    end

    context 'with valid attributes' do
      scenario '- can update book' do
        click_on 'Edit'
        fill_in 'book_author', with: 'New author name'
        fill_in 'book_title', with: 'New book title'
        fill_in 'book_tags_for_book_list', with: 'another, tags'
        fill_in 'book_description', with: 'New description for book'
        click_on 'Update book'

        expect(page).to have_content 'New author name'
        expect(page).to have_content 'New book title'
        expect(page).to have_content 'New description for book'
      end
    end

    context 'with invalid attributes' do
      scenario "- can't update book" do
        click_on 'Edit'
        fill_in 'book_author', with: ''
        fill_in 'book_title', with: ''
        fill_in 'book_tags_for_book_list', with: ''
        fill_in 'book_description', with: ''
        click_on 'Update book'

        expect(page).to have_content '3 errors prohibited this book from being saved'
        expect(page).to have_content 'Title is too short (minimum is 1 character)'
        expect(page).to have_content "Author can't be blank"
        expect(page).to have_content "Description can't be blank"
      end
    end
  end

  describe 'Non-Authenticated user' do
    scenario "- can't see update btn" do
      visit book_path(book, locale: 'en')

      expect(page).to_not have_content 'Edit'
    end
  end
end
