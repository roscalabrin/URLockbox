class Link < ApplicationRecord
  belongs_to :user
  
  validates :title, presence: true
  validates :url, presence: true
  validates :homepage, :url => true
end