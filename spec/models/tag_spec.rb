require 'spec_helper'

describe Tag do
  describe 'validations' do
    it 'should require name to be present' do
      tag = build :tag, name: nil
      expect(tag.valid?).to be false
      expect(tag.errors).to have_key :name
      expect(tag.errors[:name]).to include "can't be blank"
    end

    it 'should require name to be unique' do
      Tag.create(name: 'videotutorials')
      tag = Tag.new(name: 'videotutorials')
      expect(tag.valid?).to be false
      expect(tag.errors).to have_key :name
      expect(tag.errors[:name]).to include "has already been taken"
    end

    it 'should require name to be at least 2 characters long' do
      tag = build :tag, name: "A"
      expect(tag.valid?).to be false
      expect(tag.errors).to have_key :name
      expect(tag.errors[:name]).to include "is too short (minimum is 2 characters)"
    end

    it 'should only allow aalphanumeric characters, _, -, + and # in tag name' do
      forbidden_names = ['with space', 'abc***', '$$$']
      forbidden_names.each do |name|
        tag = build :tag, name: name
        expect(tag.valid?).to be false
        expect(tag.errors).to have_key :name
        expect(tag.errors[:name]).to include "is invalid"
      end
    end
  end
end
