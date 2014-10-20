class CreateResource < ActiveRecord::Migration
  def change
    create_table :resources do |t|
      t.string :name, null: false
      t.text :description
      t.text :url, null: false

      t.belongs_to :topic, null: false

      t.timestamps
    end

    add_index :resources, :topic_id
  end
end
