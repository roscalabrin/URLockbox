require 'rails_helper'

describe "User can search links", type: :feature, js: true do
  before do
    user = create(:user)
    link1 = create(:link, title: "weather forecast", user_id: user.id)
    link2 = create(:link, title: "restaurants", user_id: user.id)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit links_path
  end
  
  it "shows only links that fit the search criteria" do
    within ('.search-form') do
      fill_in "search", with: "weather"
    end
  
    expect(page).to have_content "weather forecast"
    expect(page).to_not have_content "restaurants"
  end
end