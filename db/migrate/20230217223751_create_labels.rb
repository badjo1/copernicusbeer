class CreateLabels < ActiveRecord::Migration[7.0]
  def change
    create_table :labels do |t|
      t.references :batch, null: false, foreign_key: true
      t.string :code, null: false
      t.string :description
      t.integer :number_of_labels, null: false
      t.timestamps
      t.index [ :code ], unique: true
    end
  end
end
