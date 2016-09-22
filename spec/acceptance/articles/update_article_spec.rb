require_relative '../../acceptance/acceptance_helper'

feature 'Create Article', '
        I want be able to add article
  ' do

  given!(:admin_user) { create(:admin_user) }
  given!(:article)    { create(:article) }

  describe 'Authenticated user' do

    before do
      sign_in(admin_user)
      visit article_path(article, locale: 'en')
    end

    context 'with valid attributes' do
      scenario '- can update article' do
        click_on 'Update article'
        fill_in 'article_title', with: 'Test article update'
        click_on 'Update article'
        click_on 'Log Out'

        expect(page).to have_content 'Test article update'
        expect(page).to have_content 'This is Test article preview'
      end
    end


    context 'with invalid attributes' do
      scenario "- can't update article" do
        click_on 'Update article'
        fill_in 'article_title', with: ''
        fill_in 'article_tags_for_article_list', with: ''
        fill_in 'article_preview', with: ''
        fill_in 'article_content', with: ''
        click_on 'Update article'

        expect(page).to have_content '4 errors prohibited this article from being saved'
        expect(page).to have_content 'Title is too short (minimum is 1 character)'
        expect(page).to have_content "Content can't be blank"
        expect(page).to have_content "Preview can't be blank"
        expect(page).to have_content "Tags for article list can't be blank"
      end
    end
  end

  describe 'Non-Authenticated user' do
    scenario '- fails to create question and redirected to sign in page' do
      visit article_path(article, locale: 'en')

      expect(page).to_not have_content 'Update article'
    end
  end

end
