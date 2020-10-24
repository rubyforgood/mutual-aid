require 'rails_helper'

RSpec.describe ContactMethodsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/contact_methods').to route_to('contact_methods#index')
    end

    it 'routes to #new' do
      expect(get: '/contact_methods/new').to route_to('contact_methods#new')
    end

    it 'routes to #show' do
      expect(get: '/contact_methods/1').to route_to('contact_methods#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/contact_methods/1/edit').to route_to('contact_methods#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/contact_methods').to route_to('contact_methods#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/contact_methods/1').to route_to('contact_methods#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/contact_methods/1').to route_to('contact_methods#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/contact_methods/1').to route_to('contact_methods#destroy', id: '1')
    end
  end
end
