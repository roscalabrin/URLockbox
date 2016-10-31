require 'rails_helper'

feature "User can sign out" do
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
    
    click_link "Sign Out"
    
    expect(current_path).to eq root_path
  end
end