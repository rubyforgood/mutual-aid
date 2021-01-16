# frozen_string_literal: true

ContributionType = Struct.new(:id, :name, :model)
class ContributionType
  TYPES = [new('Ask', 'Ask', Ask), new('Offer', 'Offer', Offer)].freeze

  def self.as_filter_types
    TYPES
  end

  def self.where(id: [], name: [])
    ids = (id + name).flatten
    ids.map {|i| TYPES.find {|t| t.id == i }}
  end
end
