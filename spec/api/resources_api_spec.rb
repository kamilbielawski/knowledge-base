require 'spec_helper'
require 'api/api_helper'

describe 'Resources API' do
  # GET /api/v1/topics/:id/resources
  describe :index do
    it 'should return 404 error if no topic with requested id exists' do
      resp = api_get 'topics/42/resources'
      expect(response.status).to eql(404)
      expect(resp['message']).to eql('Resource not found')
    end

    it 'should return empty array if no resources exist for a topic' do
      topic = create :topic
      resp = api_get "topics/#{topic.id}/resources"
      expect(response.status).to eql(200)
      expect(resp).to eql([])
    end

    it 'should return an array of existing resources' do
      topic = create :topic
      2.times{ create :resource }
      resp = api_get "topics/#{topic.id}/resources"
      expect(response.status).to eql(200)
      expect(resp.count).to eql(2)
    end

    it 'should sort results by updated_at timestamp' do
      topic = create :topic
      first_resource = create :resource
      second_resource = create :resource
      first_resource.update_attribute :name, 'ABC'
      resp = api_get "topics/#{topic.id}/resources"
      expect(resp.first['id']).to eql(first_resource.id)
      expect(resp.second['id']).to eql(second_resource.id)
    end
  end

  # POST /api/v1/topics/:id/resources
  describe :create do
    let(:resource_params) { {name: 'Name', description: 'Description', url: 'http://example.com/res.html' } }

    it 'should return 404 error if no topic with requested id exists' do
      resp = api_post "topics/42/resources", resource: resource_params
      expect(response.status).to eql(404)
      expect(resp['message']).to eql('Resource not found')
    end

    context 'with existing topic' do
      let(:topic) { create :topic }

      it 'should create resource when parameters are correct and return new entity' do
        resp = nil
        expect {
          resp = api_post "topics/#{topic.id}/resources", resource: resource_params
        }.to change(Resource, :count).by(1)
        expect(response.status).to eql(200)
        expect(resp['id']).to be_present
        expect(resp['name']).to be_present
      end

      it 'should create association between topic and resource' do
        expect {
          resp = api_post "topics/#{topic.id}/resources", resource: resource_params
        }.to change(topic.resources, :count).by(1)
        expect(Resource.last.topic).to eq(topic)
      end
    end
  end
end
