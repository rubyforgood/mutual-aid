# frozen_string_literal: true

class AddPersonDetailsFromClaimParams < ActiveInteraction::Base
  object :user
  string :name
  integer :preferred_contact_method_id
  string :contact_info

  def execute
    if person.blank?
      Person.create!(person_params)
    else
      person.update!(person_params.except(:name))
    end
  end

  private

  def preferred_contact_method
    ContactMethod.find(preferred_contact_method_id)
  end

  def preferred_contact_method_field
    preferred_contact_method.field.to_sym
  end

  def person_params
    person_params = { name: name,
                      preferred_contact_method: preferred_contact_method,
                      user: user }
    person_params[preferred_contact_method_field] = contact_info
    person_params
  end

  def person
    user.person
  end
end
