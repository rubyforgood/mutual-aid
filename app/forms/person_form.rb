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
    (id? ? Person.find(id) : Person.new).tap do |person|
      person.attributes = given_inputs
    end
  end
end
