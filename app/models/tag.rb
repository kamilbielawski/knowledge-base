class Tag < ActiveRecord::Base
  validates :name, presence: true,
                   length: { minimum: 2 },
                   uniqueness: true

  has_many :resources_tags
  has_many :resources, through: :resources_tags
end
