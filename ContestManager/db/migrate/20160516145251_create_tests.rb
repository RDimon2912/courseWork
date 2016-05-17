class CreateTests < ActiveRecord::Migration
  def change
    create_table :tests do |t|
    	t.integer :task_id
    	t.string :path_in
    	t.string :path_out
    end
  end
end
