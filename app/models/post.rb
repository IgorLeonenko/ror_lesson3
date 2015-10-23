class Post < ActiveRecord::Base
  validates_presence_of :title, :body
  validates :title, uniqueness: true, length: { in: 5..100 }
end
