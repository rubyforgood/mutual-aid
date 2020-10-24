# frozen_string_literal: true

module IndexActionButtons
  def clear_search_button(path=nil)
    if path
      link = path
    else
      action = action_name == 'index' ? '' : action_name
      link = "/#{controller_path}/#{action}"
    end
    "<a class='button is-primary is-outlined' href=#{link}>Clear</span></a>".html_safe
  end
end
