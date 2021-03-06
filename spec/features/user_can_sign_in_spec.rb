require 'rails_helper'

feature "User can sign in" do
  before do
    User.create(email: "roberta@example.com", password: "password")
  end
  scenario "user provides valid login information" do
    visit root_path
    click_link "Sign In"
    
    expect(current_path).to eq login_path
    fill_in :session_email, with: "roberta@example.com"
    fill_in :session_password, with: "password"
    click_button "Sign In"

    expect(current_path).to eq links_path
    expect(page).to have_content "Sign Out"
  end

  scenario "user provides invalid information" do
    visit root_path
    click_link "Sign In"
    fill_in :session_email, with: "roberta@example.com"
    fill_in :session_password, with: "xxx"
    click_button "Sign In"

    expect(current_path).to eq login_path
    expect(page).to have_content "Invalid username or password. Try Again."
  end
end
