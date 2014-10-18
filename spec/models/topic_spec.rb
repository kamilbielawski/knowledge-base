require 'spec_helper'

describe Topic do
  describe 'validations' do
    it 'should require name to be present' do
      topic = Topic.new
      expect(topic.valid?).to be false
      expect(topic.errors).to have_key :name
      expect(topic.errors[:name]).to include "can't be blank"
    end

    it 'should require name to be unique' do
      Topic.create(name: 'AngularJS')
      topic = Topic.new(name: 'AngularJS')
      expect(topic.valid?).to be false
      expect(topic.errors).to have_key :name
      expect(topic.errors[:name]).to include "has already been taken"
    end

    it 'should require name to be at least 3 characters long' do
      topic = Topic.new(name: 'ab')
      expect(topic.valid?).to be false
      expect(topic.errors).to have_key :name
      expect(topic.errors[:name]).to include "is too short (minimum is 3 characters)"
    end
  end
end
