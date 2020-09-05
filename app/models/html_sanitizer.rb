class HtmlSanitizer
  def self.tags
    %w[a abbr b blockquote br cite code dd dfn div dl dt h1 h2 h3 h4 h5 h6 img
       kbd li mark ol p pre q s samp small span strike sub sup time ul var]
  end

  def self.html_attributes
    %w[align alt border height src srcset width href hreflang name rel
         value type class dir hidden id lang style tabindex title translate src]
  end

  def initialize(string)
    @string = string
  end

  def sanitize_for_rails
    return "" unless @string
    safe_list_sanitizer = Rails::Html::SafeListSanitizer.new
    safe_list_sanitizer.sanitize(@string,
                                 tags: self.class.tags, attributes: self.class.html_attributes).html_safe
  end

  def sanitize_for_vue
    sanitize_for_rails.gsub(/"/, "\\\"").gsub(/'/, "\\'").gsub(/[\r\n]+/, "\\\n").html_safe
  end
end
