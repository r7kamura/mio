module ApplicationHelper
  def iphone_title(title)
    render :partial => "iphone/header", :locals => {:title => title}
  end

  def javascript_include_mathjax_tag
    raw <<-"EOF"
    <script type="text/x-mathjax-config">
      MathJax.Hub.Config({ tex2jax: { inlineMath: [['$','$'], ["\\(","\\)"]] } });
    </script>
    #{javascript_include_tag "http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS_HTML"}
    <meta http-equiv="X-UA-Compatible" CONTENT="IE=EmulateIE7" />
    EOF
  end

  def image_tag_safe(path, opt={})
    (path.nil? || path.blank?) ?
      "" :
      image_tag(path, opt)
  end

  def icon_tag(path, opt={})
    (path.nil? || path.blank?) ?
      image_tag("/images/default_icon.png", opt) :
      image_tag(path, opt)
  end

  def user_icon(user, opt={})
    link_to icon_tag(user.profile_image_url, opt), user_timeline_url(user.screen_name), :class => :icon
  end

  def jp_time(time)
    time.localtime.strftime("%y/%m/%d %H:%M")
  end

  def jp_date(time)
    time.localtime.strftime("%y/%m/%d")
  end

  def jp_date_long(time)
    time.localtime.strftime("%Y/%m/%d")
  end

end
