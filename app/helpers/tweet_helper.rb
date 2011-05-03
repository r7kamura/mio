module TweetHelper

  def linkify(str)
    str = linkify_url(str)
    str = linkify_room(str)
    str = linkify_hash_tag(str)
    str = linkify_user(str)
    str = prettify_retweet(str)
  end

  def linkify_room(str)
    str.gsub(/&(\w+)(\s+|$)/) {|txt|
      link_to("&" + $~[1], :controller => :room, :action => :show, :name => $~[1]) + $~[2]
    }.html_safe
  end

  def linkify_hash_tag(str)
    str.gsub(/#(\w+)(\s+|$)/) {|txt|
      link_to("#" + $~[1], :controller => :hash_tag, :action => :show, :name => $~[1]) + $~[2]
    }.html_safe
  end

  def linkify_user(str)
    str.gsub(/@(\w+)(\s+|$)/) {|txt|
      link_to("@" + $~[1], :controller => :user, :action => :timeline, :name => $~[1]) + $~[2]
    }.html_safe
  end

  def linkify_url(str)
    URI.extract(str.dup, %w[http https ftp]) do |uri|
      str = str.gsub(uri, %Q{<a href="#{uri}" target="_blank">#{uri}</a>}).html_safe
    end
    str
  end

  def prettify_retweet(str)
    str.sub(/(^|\s)(RT @.+ .+$)/) { "#{$1}<span class=\"retweet\">#{$2}</span>" }
  end

end
