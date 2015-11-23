class User < ActiveRecord::Base
  has_secure_password

  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorite_posts
  has_many :favorites, through: :favorite_posts, source: :post

  validates_presence_of :email, :name
  validates :name, length: {maximum: 51}
  validates :password, length: { minimum: 6 }, :if => :password
  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }, uniqueness: true

  before_save { self.email = email.downcase }

  def like?(post)
    Like.where(post_id: post.id, like: true, user_id: self.id).size > 0
  end

  def dislike?(post)
    Like.where(post_id: post.id, dislike: true, user_id: self.id).size > 0
  end

  def like
    self.likes.where(like: true).size
  end

  def to_param
    name
  end

  def rating
    post = self.posts.size
    comment = self.comments.size
    like = self.likes.where(like: true).size
    dislike = self.likes.where(dislike: true).size
    post + like + comment - dislike
  end

end
