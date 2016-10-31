require 'rails_helper'

feature "User can sign in" do
  before do
    user = User.create(email: "roberta@example.com", password: "password")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  end
  scenario "user submits a link with valid information and sees it on their links page" do
    visit links_path
    
    fill_in :title, with: "snow forecast"
    fill_in :url, with: "https://opensnow.com/"
    click_button "Create Link"

    expect(current_path).to eq links_path
    expect(page).to have_content "snow forecast"
    expect(page).to have_content "https://opensnow.com/"
  end
end