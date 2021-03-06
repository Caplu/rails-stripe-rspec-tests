# frozen_string_literal: true
include Warden::Test::Helpers
Warden.test_mode!

# Feature: User index page
#   As a user
#   I want to see a list of users
#   So I can see who has registered
feature 'User index page', :devise, js: true do
  after(:each) do
    Warden.test_reset!
  end

  # Scenario: User listed on index page
  #   Given I am signed in
  #   When I visit the user index page
  #   Then I see my own email address
  scenario 'user sees own email address' do
    user = FactoryGirl.build(:user)
    # user.role = 'admin'
    user.add_role 'admin'
    user.save!
    login_as(user, scope: :user)
    visit users_path
    expect(current_path).to eq '/users'
    expect(page).to have_content user.email
    expect(page).to have_content 'Admin'
  end
end
