class AddRatingToResource < ActiveRecord::Migration
  def change
    add_column :resources, :rating, :integer, default: 0

    add_index :resources, :rating
  end
end
