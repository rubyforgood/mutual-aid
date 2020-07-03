class RegistrationsController < Devise::RegistrationsController
  prepend_before_action :require_no_authentication, only: [:cancel]

  def new
    set_form_dropdowns
    super
  end

  def create
    build_resource(sign_up_params)

    if @current_user
      @minimum_password_length = 8 # config/initializers/devise.rb (config.password_length = 8..128)
      resource.confirmed_at = Time.current


    end

    resource.save
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        flash_message = @current_user ? :created_new_user : :signed_up
        set_flash_message! :notice, flash_message
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

  def update
    super
  end

  def set_person(params)
    person = Person.where(id: params[:person_id]).last

    if params[:person] && params[:person][:name].present?
      person ||= Person.where(name: params[:person][:name]).first_or_create!
    end
  end

  def associate_person(person, resource)
    person.user = resource
    person.save!
  end

  def set_form_dropdowns
    @contact_methods = ContactMethod.enabled # for nested Person
    @people_array = Person.order(:name).pluck(:name, :id)
  end
end