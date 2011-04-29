module ApplicationHelper

  # return random color-name for css
  def random_color(str)
    %w{black gray silver white maroon red purple fuchsia green lime olive yellow navy blue teal aquq}[str.to_i(36) % 16]
  end

  def user_icon(user, opt={})
      link_to user.profile_image_url ? image_tag(user.profile_image_url, :size => "50x50") : "",
        {:controller => :user, :action => :timeline, :id => user.id},
        :style => "background-color:" + random_color(user.email),
        :class => opt[:class] || :icon
  end
end
