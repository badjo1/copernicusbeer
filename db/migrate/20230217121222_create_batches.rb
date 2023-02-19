class CreateBatches < ActiveRecord::Migration[7.0]
  def change
    create_table :batches do |t|
      t.integer :serialnumber, null: false
      t.string :description
      t.integer :liters
      t.timestamps
      
      t.index [ :serialnumber ], unique: true
    end
  end
end
