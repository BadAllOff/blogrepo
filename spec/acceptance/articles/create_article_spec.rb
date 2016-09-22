require_relative '../../acceptance/acceptance_helper'

feature 'Create Article', '
        I want be able to add article
  ' do

  given!(:admin_user) { create(:admin_user) }
  describe 'Authenticated user' do

    before do
      sign_in(admin_user)
      visit articles_path
    end
    context 'with valid attributes' do
      scenario '- can create article' do
        click_on 'New Article'
        fill_in 'article_title', with: 'Test article'
        fill_in 'article_tags_for_article_list', with: 'Test, tags, 4ever, question body'
        attach_file 'article_image', "#{Rails.root}/spec/fixtures/css3.jpg"
        fill_in 'article_preview', with: 'Preview Preview'
        fill_in 'article_content', with: 'Content Content Content Content Content Content'
        check 'article_show'
        click_on 'Create article'
        click_on 'Log Out'

        expect(page).to have_content 'Test article'
        expect(page).to have_content 'Preview Preview'
      end
    end

    context 'with invalid attributes' do
      scenario "- can't create article" do
        click_on 'New Article'
        click_on 'Create article'

        expect(page).to have_content '5 errors prohibited this article from being saved'
        expect(page).to have_content "Image can't be blank"
        expect(page).to have_content 'Title is too short (minimum is 1 character)'
        expect(page).to have_content "Content can't be blank"
        expect(page).to have_content "Preview can't be blank"
        expect(page).to have_content "Tags for article list can't be blank"
      end
    end
  end

  describe 'Non-Authenticated user' do
    scenario '- fails to create question and redirected to sign in page' do
      visit articles_path

      expect(page).to_not have_content 'New Article'
    end
  end

end
