class CreateCompileMethods < ActiveRecord::Migration
  def change
    create_table :compile_methods do |t|
    	t.string :name
    	t.text :compilation
    	t.text :run
    	t.string :ext
      #t.timestamps null: false
    end
  end
end
