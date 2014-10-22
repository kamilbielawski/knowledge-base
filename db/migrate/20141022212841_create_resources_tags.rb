class CreateResourcesTags < ActiveRecord::Migration
  def change
    create_table :resources_tags do |t|
      t.integer :resource_id
      t.integer :tag_id

      t.timestamps
    end

    add_index :resources_tags, :resource_id
    add_index :resources_tags, :tag_id
    add_index :resources_tags, [:resource_id, :tag_id], unique: true
  end
end
