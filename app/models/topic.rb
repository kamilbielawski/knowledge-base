class Topic < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true, length: { minimum: 3 }
end
