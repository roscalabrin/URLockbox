require 'rails_helper'

describe "User can change if a link as read or not", type: :feature, js: true do
  before(:each) do
    user = create(:user)
    link = create(:link, user_id: user.id)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  end
  
  it "changes the read attribute to true" do
    visit links_path
    expect(page).to have_content "Mark as Read"
    
    within ('.all-links') do
      click_button "Mark as Read"
    end
  
    expect(page).to have_content "Mark as Unread"
  end
  
  it "changes the read attribute to false" do
    Link.last.update(read: true)
    visit links_path
    
    expect(page).to have_content "Mark as Unread"
    
    within ('.all-links') do
      click_button "Mark as Unread"
    end
  
    expect(page).to have_content "Mark as Read"
  end
end