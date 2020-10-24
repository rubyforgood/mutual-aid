require 'rails_helper'

RSpec.describe FilterTypeBlueprint do
  describe 'render' do
    it 'can serialize a class that provides `.as_filter_types`, `#name`, and `#id`' do
      initial_data = [{ id: 1, name: 'East Bay Township' }, { id: 2, name: 'Takoma' }, { id: 3, name: 'Wicomico County' }]
      service_areas = initial_data.map {|data| ServiceArea.new(data)}
      class_double = double(ServiceArea)
      expect(class_double).to receive(:as_filter_types).and_return(service_areas)

      expected_data = [
        { 'id' => 'ServiceArea[1]', 'name' => 'East Bay Township' },
        { 'id' => 'ServiceArea[2]', 'name' => 'Takoma' },
        { 'id' => 'ServiceArea[3]', 'name' => 'Wicomico County' }
      ].to_json
      actual_data = FilterTypeBlueprint.render(class_double)
      expect(actual_data).to match(/#{expected_data}\z/)
    end
  end
end