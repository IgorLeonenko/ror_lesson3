class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post

  validates_presence_of :body
  validates :body, length: {minimum: 100}

  after_create :update_post


  private

    def update_post
      self.post.update_attributes(updated_at: Time.now)
    end
end
