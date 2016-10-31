require 'rails_helper'

describe Link, type: :model do
  it { should validate_presence_of :title }
  it { should validate_presence_of :url }
  it { should belong_to :user }  
end
  