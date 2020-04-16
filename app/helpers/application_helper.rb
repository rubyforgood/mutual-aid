module ApplicationHelper

  def yes_no(boolean)
    "<span class='#{ boolean ? "fa fa-check-circle has-text-success" : "fa fa-ban" }'></span>".html_safe
  end

end
