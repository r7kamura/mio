module TweetHelper

  # return random color-name for css
  def random_color(str)
    %w{black gray silver white maroon red purple fuchsia green lime olive yellow navy blue teal aquq}[str.to_i(36) % 16]
  end

  def linkify(str)
    str = linkify_room(str)
    str = linkify_hash_tag(str)
  end

  def linkify_room(str)
    if str =~ /(?:\s+|^)&(\w+)(?:\s+|$)/
      str = str.gsub($~[1], link_to($~[1], :controller => :room, :action => :show, :name => $~[1].delete("&"))).html_safe
    end
    str
  end

  def linkify_hash_tag(str)
    if str =~ /(?:\s+|^)#(\w+)(?:\s+|$)/
      str = str.gsub($~[1], link_to($~[1], :controller => :hash_tag, :action => :show, :name => $~[1].delete("#"))).html_safe
    end
    str
  end
end
