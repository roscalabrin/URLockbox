require 'rails_helper'

describe "User can filter links", type: :feature, js: true do
  before do
    user = create(:user)
    link1 = create(:link, title: "weather forecast", read: false, user_id: user.id)
    link2 = create(:link, title: "restaurants", read: true, user_id: user.id)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit links_path
  end
  
  it "shows only links that fit the filter criteria" do
    expect(page).to have_content "weather forecast"
    expect(page).to have_content "restaurants"
    
    choose("Show Read")
    expect(page).to have_content "restaurants"
    
    choose("Show Unread")
    expect(page).to have_content "weather forecast"
    
    choose("Show All")
    expect(page).to have_content "weather forecast"
    expect(page).to have_content "restaurants"
  end
end