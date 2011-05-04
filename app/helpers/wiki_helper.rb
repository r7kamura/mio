require "rubygems"
require "RedCloth"

module WikiHelper
  def prettify_to_html(str)
    return if str.nil? or str.empty?
    RedCloth.new(str).to_html.html_safe
  end
end
