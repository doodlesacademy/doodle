class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :title
      t.text :description
      t.integer :lessons_count
      t.timestamps null: false
    end
  end
end
