UrgencyLevel = Struct.new(:id, :name, :other)
# UrgencyLevel
# We can convert this to some other type of class, such as an ActiveRecord model
# I'm hard-coding the options for now, though
class UrgencyLevel
  TYPES = [new(1, 'Within 1-2 days'), new(2, 'I can wait a week')].freeze

  def self.as_filter_types
    TYPES
  end

  def self.where(id: [])
    ids = [id].flatten
    ids.map {|i| TYPES.select {|t| t.id == i }}
  end
end
