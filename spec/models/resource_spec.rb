require 'spec_helper'

describe Resource do
  describe 'validations' do
    it 'should require name to be present' do
      resource = build :resource, name: nil
      expect(resource.valid?).to be false
      expect(resource.errors).to have_key :name
      expect(resource.errors[:name]).to include "can't be blank"
    end

    it 'should require name to be at least 3 characters long' do
      resource = build :resource, name: "Ab"
      expect(resource.valid?).to be false
      expect(resource.errors).to have_key :name
      expect(resource.errors[:name]).to include "is too short (minimum is 3 characters)"
    end

    it 'should require url to be present' do
      resource = build :resource, url: nil
      expect(resource.valid?).to be false
      expect(resource.errors).to have_key :url
      expect(resource.errors[:url]).to include "can't be blank"
    end

    it 'should require url to be valid' do
      resource = build :resource, url: 'http://'
      expect(resource.valid?).to be false
      expect(resource.errors).to have_key :url
      expect(resource.errors[:url]).to include "is an invalid URL"
    end

    it 'should only accept urls with correct protocol (http or https)' do
      resource = build :resource, url: 'ftp://resources.com/resource'
      expect(resource.valid?).to be false
      expect(resource.errors).to have_key :url
      expect(resource.errors[:url]).to include "must begin with http or https"
    end

    it 'should validate presence of topic' do
      resource = build :resource, topic: nil
      expect(resource.valid?).to be false
      expect(resource.errors).to have_key :topic
      expect(resource.errors[:topic]).to include "can't be blank"
    end
  end

  describe 'tagging' do
    it 'should be possible to add a tag to resource' do
      resource = create :resource
      tag = create :tag
      expect{
        resource.tags << tag
      }.to change(resource.tags, :count).by(1)
    end

    it 'should not be possible to add the same tag twice' do
      resource = create(:resource_with_tag)
      expect{
        resource.tags << resource.tags.last rescue nil
      }.to change(resource.tags, :count).by(0)
    end
  end
end
