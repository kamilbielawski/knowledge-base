class CreateTopic < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :name, nil: false

      t.timestamps
    end

    add_index :topics, :name, unique: true
  end
end
