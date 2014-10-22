class ResourcesTag < ActiveRecord::Base
  validates_presence_of :resource, :tag
  validates :resource, uniqueness: {scope: :tag}

  belongs_to :resource
  belongs_to :tag
end
