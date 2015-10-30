class Post < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :title, :body
  validates :title, uniqueness: true, length: { in: 5..100 }
end
