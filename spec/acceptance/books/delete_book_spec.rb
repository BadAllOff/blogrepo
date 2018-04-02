require_relative '../../acceptance/acceptance_helper'

feature 'Delete Book', '
        I want be able to delete Book
  ' do

  given!(:admin_user) { create(:admin_user) }
  given!(:book) { create(:book) }
  describe 'Authenticated user' do
    before do
      sign_in(admin_user)
      visit book_path(book, locale: 'en')
    end

    scenario '- can see delete btn' do
      expect(page).to have_css('.btn-danger')
    end

    scenario '- can delete article' do
      # first('.fa-trash').click
      click_on('Destroy')
      expect(page).to_not have_content 'This is Test book'
      expect(page).to_not have_content 'This is Test book description'
    end
  end

  describe 'Non-Authenticated user' do
    before do
      visit book_path(book, locale: 'en')
    end

    scenario '- can see book' do
      expect(page).to have_content 'This is Test book'
    end

    scenario "- can't see delete btn" do
      expect(page).to_not have_css('.fa-trash')
    end
  end
end
