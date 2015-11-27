class Post < ActiveRecord::Base
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :post_tags
  has_many :tags, through: :post_tags
  has_many :favorite_posts
  has_many :favorited_by, through: :favorite_posts, source: :user

  validates_presence_of :title, :body, :user_id
  validates :title, uniqueness: true, length: { in: 5..140 }
  validates :body, length: { minimum: 140 }
  validates_length_of :tags, maximum: 5
  validates_format_of :image_url, with: /\.(png|jpg|gif)$/i, multiline: true, message: "must have an image extension",
                      allow_blank: true

  default_scope  { order(created_at: :desc) }
  scope :popular, -> { unscoped.select('posts.*').joins(:likes).where(likes: { like:true }).group('posts.id').having('count(posts.id) > 9') }

  def self.search(search)
    where('body LIKE :query OR title LIKE :query', query: "%#{search}%")
  end

  def like_count
    self.likes.where(like: true).size
  end

  def dislike_count
    self.likes.where(like: false).size
  end

  def tag_list
    tags.map(&:name)
  end

  def tag_list=(names)
    self.tags = names.split(",").map do |n|
      Tag.where(name: n.strip).first_or_create
    end
  end

  def favorited?(current_user)
    FavoritePost.find_by(post_id: self.id, user_id: current_user.id).present?
  end

  def self.find_by_params(params)
    posts = Post.all
    posts = posts.popular.limit(30) if params[:popular].present?
    posts = posts.unscoped.order(updated_at: :desc).limit(15) if params[:active].present?
    posts = posts.joins(:tags).where(tags: {name: params[:tag]}) if params[:tag].present?
    posts = posts.search(params[:search]) if params[:search].present?
    posts = posts.page(params[:page]).per(10) unless params[:active].present?
    posts
  end
end
