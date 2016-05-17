class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
    	t.string :name
    	t.text :description
    	t.string :path
    	t.integer :time_limit

      #t.timestamps null: false
    end
  end
end
