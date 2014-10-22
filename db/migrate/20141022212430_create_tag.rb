class CreateTag < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :name, nil: false

      t.timestamps
    end

    add_index :tags, :name, unique: true
  end
end
