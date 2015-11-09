class Post < ActiveRecord::Base
  belongs_to :user
  has_many :likes, dependent: :destroy

  validates_presence_of :title, :body
  validates :title, uniqueness: true, length: { in: 5..100 }

  before_save :sharp_to_tag

  default_scope  { order(:created_at => :desc) }

  def self.search(search)
    if search
      where('body LIKE :query OR title LIKE :query', query: "%#{search}%")
    else
      all
    end
  end

  def like_count
    Like.where(like: true, post_id: self.id).size
  end

  def dislike_count
    Like.where(dislike: true, post_id: self.id).size
  end

  private

  def sharp_to_tag
    self.tags = self.tags.scan(/\w+/).map{|i| '#' + i}.join(" ") if self.tags
  end
end
