class Comment < ActiveRecord::Base
  has_ancestry cache_depth: true

  belongs_to :user
  belongs_to :post

  validates_presence_of :body
  validates :body, length: {in: 10..200}

  after_create :update_post


  private

    def update_post
      self.post.update_attribute(:updated_at, Time.now)
    end
end
