require 'rails_helper'

RSpec.describe MobilityStringTranslationsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/mobility_string_translations').to route_to('mobility_string_translations#index')
    end

    it 'routes to #new' do
      expect(get: '/mobility_string_translations/new').to route_to('mobility_string_translations#new')
    end

    it 'routes to #show' do
      expect(get: '/mobility_string_translations/1').to route_to('mobility_string_translations#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/mobility_string_translations/1/edit').to route_to('mobility_string_translations#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/mobility_string_translations').to route_to('mobility_string_translations#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/mobility_string_translations/1').to route_to('mobility_string_translations#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/mobility_string_translations/1').to route_to('mobility_string_translations#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/mobility_string_translations/1').to route_to('mobility_string_translations#destroy', id: '1')
    end
  end
end
