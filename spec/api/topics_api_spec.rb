require 'spec_helper'
require 'api/api_helper'

describe 'Topics API' do
  # GET /api/v1/topics
  describe :index do
    it 'should return empty array if no topics exist' do
      resp = api_get 'topics'
      expect(resp).to eql([])
    end

    it 'should return an array of exisiting topics' do
      2.times { create :topic }
      resp = api_get 'topics'
      expect(resp).to have(2).topics
    end
  end

end
