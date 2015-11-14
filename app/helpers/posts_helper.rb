module PostsHelper
  def like_count(post)
    post.like_count != 0 ? post.like_count : '0'
  end

  def dislike_count(post)
    post.dislike_count != 0 ? post.dislike_count : '0'
  end

  def like_dislike(like, post)
    if like
      "<span class='text-primary' id='like-#{post.id}'>
        #{like_count(post)}
      </span>".html_safe
    else
      "<span class='text-danger' id='dislike-#{post.id}'>
      #{dislike_count(post)}
      </span>".html_safe
    end
  end

  def like_thumb(current_user, post)
    if current_user.id == post.user_id || current_user.like?(post)
      "<a class='likes like-#{post.id}' data-placement='bottom' data-toggle='tooltip' title='#{current_user.like?(post) ? 'Only one time!' : 'You cant like own post'}'>
        <span class='fa fa-thumbs-up text-primary'></span>
      </a>".html_safe
    else
      link_to '<span class="fa fa-thumbs-up text-primary"></span>'.html_safe, like_path(post.id, current_user.id),
              class: "likes like-#{post.id}", method: :post, remote: true
    end
  end

  def dislike_thumb(current_user, post)
    if current_user.id == post.user_id || current_user.dislike?(post)
      "<span class='dislikes dislike-#{post.id}' data-placement='bottom' data-toggle='tooltip' title='#{ current_user.dislike?(post) ? 'Only one time!' : 'You cant dislike own post'}'>
        <span class='fa fa-thumbs-down text-danger'></span>
      </a>".html_safe
    else
      link_to '<span class="fa fa-thumbs-down text-danger"></span>'.html_safe, dislike_path(post.id, current_user.id),
              class: "dislikes dislike-#{post.id}", method: :post, remote: true
    end
  end
end
