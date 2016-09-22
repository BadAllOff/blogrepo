require 'acceptance/acceptance_helper'

feature 'Register', '
  In order to be able ask questions
  As an user
  I want be able to sign in
 ' do

  given(:user) { create(:user) }

  context 'Registered user' do
    before { sign_in(user) }

    scenario '- tries to sign in' do
      expect(page).to have_content 'Signed in successfully.'
      expect(current_path).to eq root_path
    end

    scenario '- tries to edit profile' do
      visit edit_user_registration_path
      fill_in 'user_username', with: 'NewUsername'
      fill_in 'user_current_password', with: user.password
      click_on 'Update'

      expect(page).to have_content 'Your account has been updated successfully.'
      expect(current_path).to eq root_path
    end

    scenario '- tries to sign out' do
      click_on 'Log Out'
      expect(page).to have_content 'Signed out successfully.'
      expect(current_path).to eq root_path
    end

    scenario '- tries to register new account and fails' do
      visit new_user_session_path
      expect(page).to have_content 'You are already signed in.'
      expect(current_path).to eq root_path
    end
  end

  context 'Non-registered user' do
    scenario '- tries to sign in' do
      visit new_user_session_path
      within('.card-container') do
        fill_in 'Email', with: 'wrong@user.com'
        fill_in 'Password', with: '12345'
        click_on 'Log In'
      end

      expect(page).to have_content 'Invalid email or password.'
      expect(current_path).to eq new_user_session_path(locale: 'en')
    end

    scenario '- tries to register new account' do
      # turn on mailcatcher!
      visit new_user_registration_path

      fill_in 'user_username', with: 'Newu2ername'
      fill_in 'user_email', with: 'new@user.com'
      fill_in 'user_password', with: '12345678'
      fill_in 'user_password_confirmation', with: '12345678'
      click_on 'Sign Up'

      expect(page).to have_content 'A message with a confirmation link has been sent to your email address.'
      expect(current_path).to eq root_path
    end
  end
end
