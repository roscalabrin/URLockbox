require 'rails_helper'

feature "Guest can sign up" do
  scenario "guest provides valid information" do
    visit root_path
    click_link "Sign Up"
    
    expect(current_path).to eq new_user_path
    fill_in :user_email, with: "roberta@example.com"
    fill_in :user_password, with: "password"
    fill_in :user_password_confirmation, with: "password"
    click_button "Sign Up"

    expect(current_path).to eq links_path
  end
  
  scenario "guest provides invalid information" do
    visit root_path
    click_link "Sign Up"
    
    expect(current_path).to eq new_user_path
    fill_in :user_email, with: "roberta@example.com"
    fill_in :user_password, with: "password"
    fill_in :user_password_confirmation, with: "pass"
    click_button "Sign Up"

    expect(current_path).to eq users_path
    expect(page).to have_content "Password confirmation doesn't match Password"
  end
end