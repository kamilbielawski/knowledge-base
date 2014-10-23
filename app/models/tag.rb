class Tag < ActiveRecord::Base
  validates :name, presence: true,
                   length: { minimum: 2 },
                   uniqueness: true,
                   format: { with: /\A[a-zA-Z0-9\-_+#]+\z/ }

  has_many :resources_tags
  has_many :resources, through: :resources_tags
end
