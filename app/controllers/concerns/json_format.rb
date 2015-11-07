module JsonFormat
  extend ActiveSupport::Concern

  private

  def json_format(post)
    post.to_json(only:[:id, :body, :title, :tags], :include => {:user => {:only => :name}} )
  end
end