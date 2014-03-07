class CreateDatapoints < ActiveRecord::Migration
  def change
    create_table :datapoints do |t|
      t.references :watch
      t.float :value
      
      t.timestamps
    end
  end
end
