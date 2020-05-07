class SaveLocation < BaseInteractor
  integer :id, default: nil
  string :city
  string :state

  def execute
    merging_errors do
      if id?
        Location.update(id, inputs)
      else
        Location.create(inputs)
      end
    end
  end
end
