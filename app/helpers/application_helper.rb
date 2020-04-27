module ApplicationHelper

  def yes_no(boolean)
    "<span class='#{ boolean ? "fa fa-check-circle has-text-success" : "fa fa-ban" }'></span>".html_safe
  end

  def edit_button(resource)
    if resource && action_name != "edit"
      if resource.class.superclass != ApplicationRecord
        resource = resource.becomes(resource.class.superclass)
      end
      link_to(edit_polymorphic_path(resource),
              title: action_name + " " + controller_path,
              class: 'button edit-button') do
        "<span class='fa fa-edit'></span><span style='padding-left: 0.25em'> Edit</span>".html_safe
      end
    end
  end

end
