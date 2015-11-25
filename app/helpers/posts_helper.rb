module PostsHelper

  def like_dislike(like, post)
    if like
      "<span class='text-primary' id='like-#{post.id}'>
        #{post.like_count}
      </span>".html_safe
    else
      "<span class='text-danger' id='dislike-#{post.id}'>
      #{post.dislike_count}
      </span>".html_safe
    end
  end

  def like_thumb(current_user, post)
    if current_user.id == post.user_id || current_user.like?(post)
      "<a class='likes like-#{post.id} btn btn-info' data-placement='top' data-toggle='tooltip' title='#{current_user.like?(post) ? 'Only one time!' : 'You cant like own post'}'>
        <span class='fa fa-thumbs-up text-primary'></span>
        #{like_dislike(like=true, post)}
      </a>".html_safe
    else
      link_to "<span class='fa fa-thumbs-up text-primary'></span> #{like_dislike(like=true, post)}".html_safe, like_path(post.id, current_user.id),
              class: "likes like-#{post.id} btn btn-info", method: :post, remote: true
    end
  end

  def dislike_thumb(current_user, post)
    if current_user.id == post.user_id || current_user.dislike?(post)
      "<a class='dislikes dislike-#{post.id} btn btn-danger' data-placement='top' data-toggle='tooltip' title='#{ current_user.dislike?(post) ? 'Only one time!' : 'You cant dislike own post'}'>
        <span class='fa fa-thumbs-down text-danger'></span>
        #{like_dislike(like=false, post)}
      </a>".html_safe
    else
      link_to "<span class='fa fa-thumbs-down text-danger'></span> #{like_dislike(like=false, post)}".html_safe, dislike_path(post.id, current_user.id),
              class: "dislikes dislike-#{post.id} btn btn-danger", method: :post, remote: true
    end
  end
end
