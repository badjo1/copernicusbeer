class CreateQrtags < ActiveRecord::Migration[7.0]
  def change
    create_table :qrtags do |t|
      t.references :qrcode, null: false, foreign_key: true
      t.references :label, null: false, foreign_key: true
      t.references :qrlink, null: true, foreign_key: true
      t.datetime :claimed_on 
      t.string :code, null: false
      t.timestamps
      t.index [:label_id,:code ], unique: true
    end
  end
end
