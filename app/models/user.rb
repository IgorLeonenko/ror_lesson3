class User < ActiveRecord::Base
  has_secure_password

  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates_presence_of :email, :name
  validates :name, length: {maximum: 51}
  validates :password, length: { minimum: 6 }, :if => :password
  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }, uniqueness: true

  before_save { self.email = email.downcase }

  def like?(post)
    Like.where('post_id = ? AND like = ? AND user_id = ?', post.id, true, self.id).size > 0
  end

  def dislike?(post)
    Like.where('post_id = ? AND dislike = ? AND user_id = ?', post.id, true, self.id).size > 0
  end
end
