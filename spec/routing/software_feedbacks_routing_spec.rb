require 'rails_helper'

RSpec.describe SoftwareFeedbacksController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/software_feedbacks').to route_to('software_feedbacks#index')
    end

    it 'routes to #new' do
      expect(get: '/software_feedbacks/new').to route_to('software_feedbacks#new')
    end

    it 'routes to #show' do
      expect(get: '/software_feedbacks/1').to route_to('software_feedbacks#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/software_feedbacks/1/edit').to route_to('software_feedbacks#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/software_feedbacks').to route_to('software_feedbacks#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/software_feedbacks/1').to route_to('software_feedbacks#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/software_feedbacks/1').to route_to('software_feedbacks#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/software_feedbacks/1').to route_to('software_feedbacks#destroy', id: '1')
    end
  end
end
