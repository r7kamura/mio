module TweetHelper

  def linkify(str)
    str = linkify_url(str)
    str = linkify_room(str)
    str = linkify_hash_tag(str)
    str = linkify_wiki(str)
    str = prettify_retweet(str)
    str = linkify_user(str)
    str = prettify_linebreak(str)
  end

  def linkify_room(str)
    str.gsub(/&(\w+)(\s+|$)/) {|txt| link_to("&#{$1}", room_show_url($1)) + $2 }.html_safe
  end

  def linkify_hash_tag(str)
    str.gsub(/#(\w+)(\s+|$)/) {|txt| link_to("##{$1}", hash_tag_show_url($1)) + $2 }.html_safe
  end

  def linkify_user(str)
    str.gsub(/@(\w+)(\s+|$)/) {|txt| link_to("@#{$1}", user_timeline_url($1)) + $2 }.html_safe
  end

  def linkify_wiki(str)
    str.gsub(/\[([^\s]+)\]/) {|txt| link_to("[#{$1}]", wiki_show_url($1)) }.html_safe
  end

  def linkify_url(str)
    replaced_uris = []
    URI.extract(str.dup, %w[http https ftp]) do |uri|
      next if replaced_uris.include?(uri)
      replaced_uris << uri
      str = str.gsub(uri, %Q{<a href="#{uri}" target="_blank">#{uri}</a>}).html_safe
    end
    str
  end

  # @を検出するため、linkify_userより前に行う必要がある
  def prettify_retweet(str)
    str.sub(/(^|\s)(RT @.+ (?:.|\n)+$)/) { "#{$1}<span class=\"retweet\">#{$2}</span>" }
  end

  def prettify_linebreak(str)
    str.gsub("\n", "<br>".html_safe)
  end

  def extract_images(str)
    images = []
    URI.extract(str.dup, %w[http]) do |uri|
      if uri.match(/\.(?:jpg|jpeg|png|gif|bmp)$/i)
        target = %Q{<img src="#{uri}" alt="" />}
      end
      images << %Q{<a href="#{uri}" target="_blank">#{target}</a>}.html_safe
    end
    images.empty? ? nil : images
  end
end
