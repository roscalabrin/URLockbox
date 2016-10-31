require 'rails_helper'

RSpec.describe Api::V1::LinksController, type: :request do
  describe "PUT #update" do
    it "returns the updated link" do
      link = create(:link, title: "snow forecast")
      expect(Link.count).to eq 1
      expect(Link.last.read).to eq false
      
  
      put "/api/v1/links/#{link.id}"
      expect(response).to be_success
      result = JSON.parse(response.body)
      expect(result["title"]).to eq "snow forecast"
      expect(Link.count).to eq 1
      expect(Link.last.read).to eq true
    end
  end
end  
  