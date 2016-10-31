require 'rails_helper'

feature "User views list of links in alphabetical order" do
  before(:each) do
    user = create(:user)
    link1 = create(:link, title: "snow", user_id: user.id)
    link2 = create(:link, title: "denver schools", user_id: user.id)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  end
  
  scenario "user adds link and views the list in alphabetical order" do
    visit links_path

    click_button "Sort Link Titles Alphabetically"
  end
end
  
  