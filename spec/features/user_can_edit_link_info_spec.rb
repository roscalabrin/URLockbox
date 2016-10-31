require 'rails_helper'

feature "User submit a new link" do
  before(:each) do
    user = create(:user)
    link = create(:link, user_id: user.id)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  end
  
  scenario "user edits link info" do
    visit links_path
    
    expect(page).to have_content "snow forecast"
    expect(page).to have_content "https://opensnow.com/"
    
    click_link "Edit Link"
    expect(current_path).to eq edit_link_path(Link.last)

    fill_in "Title", with: "EDITED"
    fill_in "Url", with: "https://opensnow.com/"
    save_and_open_page
    click_button "Save"

    expect(current_path).to eq links_path

    # expect(page).to have_content "snow forecastEDITED"
    # expect(page).to have_content "https://opensnow.com/"
    # expect(page).to_not have_content "snow forecast"
  end
  
  scenario "user cannot edit a link with a bad URL" do
    visit links_path
    click_link "Edit Link"

    fill_in "Url", with: "www.opensnow.com"
    click_button "Save"

    expect(page).to have_content "Url is not a valid URL"
  end
end