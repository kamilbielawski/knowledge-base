class Resource < ActiveRecord::Base
  validates :name, presence: true,
                   length: { minimum: 3 }
  validates :url, presence: true,
                  uri: true
  validates :topic, presence: true

  validates :rating, numericality: { only_integer: true }

  belongs_to :topic
  has_many :resources_tags
  has_many :tags, through: :resources_tags
end
