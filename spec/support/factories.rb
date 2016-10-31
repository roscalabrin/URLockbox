FactoryGirl.define do
  
  factory :user do
    email "roberta@example.com"
    password "password"
  end
  
  factory :link do
    user
    title "snow forecast"
    url "https://opensnow.com/"
  end
end