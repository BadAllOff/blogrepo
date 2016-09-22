require_relative '../../acceptance/acceptance_helper'

feature 'Create Book', '
        I want be able to add Book
  ' do

  given!(:admin_user) { create(:admin_user) }
  describe 'Authenticated user' do

    before do
      sign_in(admin_user)
      visit books_path
    end

    context 'with valid attributes' do
      scenario '- can create new book' do
        click_on 'New Book'
        fill_in 'book_author', with: 'Test book'
        attach_file 'book_book_cover', "#{Rails.root}/spec/fixtures/css3.jpg"
        fill_in 'book_title', with: 'Book title'
        fill_in 'book_tags_for_book_list', with: '4ever, book tag'
        fill_in 'book_description', with: 'This is the book description'
        click_on 'Create book'
        # click_on 'Log Out'

        expect(page).to have_content 'Test book'
        expect(page).to have_content 'Book title'
        expect(page).to have_content 'This is the book description'
        expect(page).to have_xpath("//img[contains(@src,'css3.jpg')]")
      end
    end

    context 'with invalid attributes' do
      scenario "- can't create article" do
        click_on 'New Book'
        click_on 'Create book'

        expect(page).to have_content '4 errors prohibited this book from being saved'
        expect(page).to have_content "Book cover can't be blank"
        expect(page).to have_content 'Title is too short (minimum is 1 character)'
        expect(page).to have_content "Author can't be blank"
        expect(page).to have_content "Description can't be blank"
      end
    end
  end

  describe 'Non-Authenticated user' do
    scenario '- fails to create question and redirected to sign in page' do
      visit articles_path

      expect(page).to_not have_content 'New Book'
    end
  end

end
