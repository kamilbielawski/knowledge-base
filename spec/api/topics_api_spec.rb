require 'spec_helper'
require 'api/api_helper'

describe 'Topics API' do
  # GET /api/v1/topics
  describe :index do
    it 'should return empty array if no keywords provided' do
      resp = api_get 'topics'
      expect(response.status).to eql(200)
      expect(resp).to eql([])
    end

    it 'should return array of all topics when all parameter provided' do
      2.times { create :topic }
      resp = api_get 'topics', all: true
      expect(response.status).to eql(200)
      expect(resp.count).to eql(2)
    end

    it 'should return empty array if no topic mathces search string' do
      2.times { create :topic }
      resp = api_get 'topics', keywords: 'ruby'
      expect(response.status).to eql(200)
      expect(resp).to eql([])
    end

    it 'should return array of topics matching search string' do
      ruby = create :topic, name: 'Ruby'
      rails = create :topic, name: 'Ruby on Rails'
      angular = create :topic, name: 'AngularJS'
      resp = api_get 'topics', keywords: 'ruby'
      expect(response.status).to eql(200)
      expect(resp.count).to eql(2)
      expect(resp.map{|r| r['id']}).to include(ruby.id)
      expect(resp.map{|r| r['id']}).to include(rails.id)
    end
  end

  # GET /api/v1/topics/:id
  describe :show do
    it 'should return topic' do
      topic = create :topic
      resp = api_get "topics/#{topic.id}"
      expect(response.status).to eql(200)
      expect(resp['id']).to eql(topic.id)
      expect(resp['name']).to eql(topic.name)
    end

    it 'should return error code when topic doesn\'t exist' do
      resp = api_get "topics/42"
      expect(response.status).to eql(404)
      expect(resp['message']).to eql('Resource not found')
    end
  end

  # DELETE /api/v1/topics/:id
  describe :destroy do
    it 'should delete topic with given id' do
      topic = create :topic
      expect {
        resp = api_delete "topics/#{topic.id}"
      }.to change(Topic, :count).by(-1)
      expect(response.status).to eql(200)
    end

    it 'should return deleted entity' do
      topic = create :topic
      resp = api_delete "topics/#{topic.id}"
      expect(response.status).to eql(200)
      expect(resp['id']).to eql(topic.id)
      expect(resp['name']).to eql(topic.name)
    end

    it 'should return error code when topic doesn\'t exist' do
      resp = api_delete "topics/42"
      expect(response.status).to eql(404)
      expect(resp['message']).to eql('Resource not found')
    end
  end

end
