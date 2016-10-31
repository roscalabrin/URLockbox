class Link < ApplicationRecord
  default_scope { order('id ASC') }
  belongs_to :user
  
  validates :title, presence: true
  validates :url, presence: true
  validates :url, :url => true
end