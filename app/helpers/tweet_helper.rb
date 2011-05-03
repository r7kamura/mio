module TweetHelper

  def linkify(str)
    str = linkify_url(str)
    str = linkify_room(str)
    str = linkify_hash_tag(str)
    str = linkify_user(str)
  end

  def linkify_room(str)
    if str =~ /&(\w+)(?:\s+|$)/
      str = str.gsub($~[1], link_to($~[1], :controller => :room, :action => :show, :name => $~[1].delete("&"))).html_safe
    end
    str
  end

  def linkify_hash_tag(str)
    if str =~ /#(\w+)(?:\s+|$)/
      str = str.gsub($~[1], link_to($~[1], :controller => :hash_tag, :action => :show, :name => $~[1].delete("#"))).html_safe
    end
    str
  end

  def linkify_user(str)
    if str =~ /@(\w+)(?:\s+|$)/
      str = str.gsub($~[1], link_to($~[1], :controller => :user, :action => :timeline, :name => $~[1].delete("@"))).html_safe
    end
    str
  end

  def linkify_url(str)
    URI.extract(str.dup, %w[http https ftp]) do |uri|
      str = str.gsub(uri, %Q{<a href="#{uri}" target="_blank">#{uri}</a>}).html_safe
    end
    str
  end

end
