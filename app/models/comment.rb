class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post

  validates_presence_of :body
  validates :body, length: {minimum: 100}
end
