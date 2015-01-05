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

  # PUT /api/v1/resources/:id/add_tag?tag=:tag
  describe :add_tag do
    let(:tag_name) { "test" }
    let(:resource) { create :resource }

    it 'should return 404 error if resource doesn\'t exist' do
      resp = api_put "resources/42/add_tag?tag=sample"
      expect(response.status).to eql(404)
      expect(resp['message']).to eql('Resource not found')
    end

    it 'should return 400 error if "tag" parameter is missing' do
      resp = api_put "resources/#{resource.id}/add_tag"
      expect(response.status).to eql(400)
      expect(resp['message']).to eql("Missing parameter: 'tag'")
    end

    it 'should add tag to resource' do
      tag = create :tag
      expect{
        resp = api_put "resources/#{resource.id}/add_tag?tag=#{tag.name}"
      }.to change(resource.tags, :count).by(1)
      expect(response.status).to eql(200)
      expect(Tag.count).to eql(1)
    end

    it 'should create tag and add it to resource if it didn\'t exist' do
      expect{
        resp = api_put "resources/#{resource.id}/add_tag?tag=#{tag_name}"
      }.to change(resource.tags, :count).by(1)
      expect(response.status).to eql(200)
      expect(resource.tags.last.name).to eq(tag_name)
      expect(Tag.count).to eql(1)
    end
  end

  # PUT /api/v1/resources/:id/vote_up
  describe :vote_up do
    let!(:resource) { create :resource }

    it 'should return 404 error if resource doesn\'t exist' do
      resp = api_put "resources/42/vote_up"
      expect(response.status).to eql(404)
      expect(resp['message']).to eql('Resource not found')
    end

    it 'should increase rating by 1' do
      expect {
        resp = api_put "resources/#{resource.id}/vote_up"
      }.to change{resource.reload.rating}.by(1)
      expect(response.status).to eql(200)
    end
  end

  # PUT /api/v1/resources/:id/vote_down
  describe :vote_up do
    let!(:resource) { create :resource }

    it 'should return 404 error if resource doesn\'t exist' do
      resp = api_put "resources/42/vote_down"
      expect(response.status).to eql(404)
      expect(resp['message']).to eql('Resource not found')
    end

    it 'should increase rating by 1' do
      expect {
        resp = api_put "resources/#{resource.id}/vote_down"
      }.to change{resource.reload.rating}.by(-1)
      expect(response.status).to eql(200)
    end
  end
end
