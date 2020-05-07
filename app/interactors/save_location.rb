class SaveLocation < ActiveInteraction::Base
  integer :id, default: nil
  string :city
  string :state

  def execute
    location = id? ?
      Location.update(id, inputs) :
      Location.create(inputs)

    errors.merge! location.errors

    location
  end
end
