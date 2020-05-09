module ApplicationHelper

  def yes_no(boolean)
    "<span class='#{ boolean ? "fa fa-check-circle has-text-success" : "fa fa-ban" }'></span>".html_safe
  end

  def edit_button(resource, button_text="Edit", icon_class="fa fa-edit")
    if resource
      resource_class = resource.class
      if resource_class.superclass != ApplicationRecord
        resource = resource.becomes(resource.class.superclass)
      end
      link_to(edit_polymorphic_path(resource),
              title: action_name || button_text + " " + controller_path || resource_class.to_s,
              class: 'button edit-button') do
        "<span class='#{icon_class}'></span><span style='padding-left: 0.25em'> #{button_text}</span>".html_safe
      end
    end
  end

  def show_button(resource, button_text="View", icon_class="fa fa-eye", margin_class=nil)
    if resource && action_name != "show"
      resource_class = resource.class
      if resource_class.superclass != ApplicationRecord
        resource = resource.becomes(resource.class.superclass)
      end
      link_to(polymorphic_path(resource),
              title: action_name || button_text + " " + controller_path || resource_class.to_s,
              class: "button show-button #{margin_class}") do
        "<span class='#{icon_class}'></span><span style='padding-left: 0.25em'> #{button_text}</span>".html_safe
      end
    end
  end
end
