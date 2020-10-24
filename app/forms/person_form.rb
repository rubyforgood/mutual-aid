# frozen_string_literal: true

class PersonForm < BaseForm
  with_options default: nil do
    integer :id
    record  :preferred_contact_method, class: ContactMethod
    record  :location
    string  :name
    string  :email
    string  :phone
    string  :skills
  end

  def execute
    Person.find_or_new(id).tap do |person|
      person.attributes = given_inputs
    end
  end
end
