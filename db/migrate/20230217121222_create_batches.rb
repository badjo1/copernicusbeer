class CreateBatches < ActiveRecord::Migration[7.0]
  def change
    create_table :batches do |t|
      t.integer :serialnumber
      t.string :description
      t.integer :liters

      t.timestamps
    end
  end
end
