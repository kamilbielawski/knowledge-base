require 'spec_helper'
require 'api/api_helper'

describe 'Topics API' do
  # GET /api/v1/topics
  describe :index do
    it 'should return empty array if no topics exist' do
      resp = api_get 'topics'
      expect(response.status).to eql(200)
      expect(resp).to eql([])
    end

    it 'should return an array of exisiting topics' do
      2.times { create :topic }
      resp = api_get 'topics'
      expect(response.status).to eql(200)
      expect(resp.count).to eql(2)
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
