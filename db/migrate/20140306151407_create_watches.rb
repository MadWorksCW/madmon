class CreateWatches < ActiveRecord::Migration
  def change
    create_table :watches do |t|
      t.string :name
      t.integer :frequency, :default => 60
      t.string :type
      t.text :config
      t.timestamps
    end
  end
end
