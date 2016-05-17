class CreateSchedulers < ActiveRecord::Migration
  def change
    create_table :schedulers do |t|

      t.timestamps null: false
    end
  end
end
