module ApplicationHelper

  # return random color-name for css
  def random_color(str)
    %w{black gray silver white maroon red purple fuchsia green lime olive yellow navy blue teal aquq}[str.to_i(36) % 16]
  end

  def user_icon(user, opt={})
      link_to user.profile_image_url.nil? || user.profile_image_url.blank? ? "" : image_tag(user.profile_image_url, :size => "50x50"),
        user_timeline_url(user.screen_name),
        :style => "background-color:" + random_color(user.email),
        :class => opt[:class] || :icon
  end

  def jp_time(time)
    time.localtime.strftime("%y/%m/%d %H:%M")
  end

end
