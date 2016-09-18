require_relative '../../acceptance/acceptance_helper'

feature 'Delete Article', '
        I want be able to delete article
  ' do

  given!(:admin_user) { create(:admin_user) }
  given!(:article) { create(:article) }
  describe 'Authenticated user' do

    before do
      sign_in(admin_user)
      visit articles_path
    end

    scenario '- can see delete btn' do
      expect(page).to have_css('.fa-trash')
    end

    scenario '- can delete article' do
      first(".btn-danger").click

      expect(page).to_not have_content 'This is Test article'
      expect(page).to_not have_content 'This is Test article preview'
    end
  end

  describe 'Non-Authenticated user' do
    before do
      visit articles_path
    end

    scenario '- can see article' do
      expect(page).to have_content 'This is Test article preview'
    end

    scenario "- can't see delete btn" do
      expect(page).to_not have_css('.fa-trash')
    end
  end

end
