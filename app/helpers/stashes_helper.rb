module StashesHelper
  include UtilityFunctions
  
  def stash_button_helper(article)
    if stashed?(article.id)
      link_to content_tag(:span, "Stashed!"), stash_path(Stash.where(article_id: article.id, user_id: current_user.id).first.id), method: :delete, remote: true, class: "button stash-delete", id: "stash_button_#{article.id}"
    else 
      render partial: "stashes/new_stash", locals: {article_id: article.id}
    end 
  end 
end
