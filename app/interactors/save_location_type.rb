class SaveLocationType < BaseInteractor
  integer :id, default: nil

  string :name

  def execute
    merging_errors do

      if id?
        LocationType.update(id, inputs)
      else
        LocationType.create(inputs)
      end
    end
  end
end
