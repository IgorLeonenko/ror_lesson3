class Post < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :title, :body
  validates :title, uniqueness: true, length: { in: 5..100 }

  before_save :sharp_to_tag

  private

  def sharp_to_tag
    self.tags = self.tags.scan(/\w+/).map{|i| '#' + i}.join(" ")
  end
end
