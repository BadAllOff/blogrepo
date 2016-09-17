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

    scenario '- creates article' do
      save_and_open_page
      click_on 'New Article'
      fill_in 'Title', with: 'Test article la la la la la l al al al a'
      fill_in 'Tags for article', with: 'Test, tags, 4ever, question body'
      fill_in 'Preview', with: 'Preview Preview PreviewPreviewPreviewPreviewPreview Preview'
      fill_in 'Content', with: 'Content Content Content Content Content Content'
      check 'article_show'
      click_on 'Create Article'

      expect(page).to have_content 'Test article la la la la la l al al al a'
      expect(page).to have_content 'Content Content Content Content Content Content'
    end
  end

  describe 'Non-Authenticated user' do

    scenario '- fails to create question and redirected to sign in page' do
      visit articles_path

      expect(page).to_not have_content 'New Article'
    end
  end

end
