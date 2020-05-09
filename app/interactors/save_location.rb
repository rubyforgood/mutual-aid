class SaveLocation < BaseInteractor
  integer :id,             default: nil
  string  :street_address, default: nil
  string  :neighborhood,   default: nil
  string  :city,           default: nil
  string  :state,          default: nil
  string  :zip,            default: nil
  string  :county,         default: nil
  string  :region,         default: nil

  # TODO: add `type` field

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
