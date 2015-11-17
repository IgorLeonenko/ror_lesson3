class Post < ActiveRecord::Base
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :tags, through: :post_tags
  has_many :post_tags, inverse_of: :post

  accepts_nested_attributes_for :tags

  validates_presence_of :title, :body, :user_id
  validates :title, uniqueness: true, length: { in: 5..140 }
  validates :body, length: { minimum: 140 }

  default_scope  { order(:created_at => :desc) }
  scope :popular, -> { unscoped.select('posts.*').joins(:likes).group('posts.id').having('count(posts.id) > 9') }

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

end
