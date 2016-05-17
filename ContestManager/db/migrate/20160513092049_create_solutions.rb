class CreateSolutions < ActiveRecord::Migration
  def change
    create_table :solutions do |t|
    	
    	t.string :path
    	t.integer :compile_method_id
    	t.integer :task_id
      t.string :verdict
      t.float :time_run
    	
      t.timestamps null: false
    end
  end
end
