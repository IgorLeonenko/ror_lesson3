class Post < ActiveRecord::Base
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :post_tags
  has_many :tags, through: :post_tags

  validates_presence_of :title, :body, :user_id
  validates :title, uniqueness: true, length: { in: 5..140 }
  validates :body, length: { minimum: 140 }
  validates_length_of :tags, maximum: 5
  validates_format_of :image_url, with: /\.(png|jpg|gif)$/i, multiline: true, message: "must have an image extension",
                      allow_blank: true

  default_scope  { order(created_at: :desc) }
  scope :popular, -> { unscoped.select('posts.*').joins(:likes).group('posts.id').having('count(posts.id) > 9') }

  def self.search(search)
    where('body LIKE :query OR title LIKE :query', query: "%#{search}%")
  end

  def like_count
    Like.where(like: true, post_id: self.id).size
  end

  def dislike_count
    Like.where(dislike: true, post_id: self.id).size
  end

  def tag_list
    tags.map(&:name)
  end

  def tag_list=(names)
    self.tags = names.split(",").map do |n|
      Tag.where(name: n.strip).first_or_create
    end
  end

  def self.find_by_params(params, current_user)
    posts = Post.all
    posts = posts.popular.limit(30) if current_user && params[:popular].present?
    posts = posts.unscoped.order(updated_at: :desc) if current_user && params[:active].present?
    posts = posts.joins(:tags).where(tags: {name: params[:tag]}) if current_user && params[:tag].present?
    posts = posts.search(params[:search]) if current_user && params[:search].present?
    posts = posts.page(params[:page]).per(10)
    posts
  end
end
