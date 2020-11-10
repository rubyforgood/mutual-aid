require 'rails_helper'

RSpec.describe SystemLocalesController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/system_locales').to route_to('system_locales#index')
    end

    it 'routes to #new' do
      expect(get: '/system_locales/new').to route_to('system_locales#new')
    end

    it 'routes to #show' do
      expect(get: '/system_locales/1').to route_to('system_locales#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/system_locales/1/edit').to route_to('system_locales#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/system_locales').to route_to('system_locales#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/system_locales/1').to route_to('system_locales#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/system_locales/1').to route_to('system_locales#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/system_locales/1').to route_to('system_locales#destroy', id: '1')
    end
  end
end
