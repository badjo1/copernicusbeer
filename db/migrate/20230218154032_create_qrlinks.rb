class CreateQrlinks < ActiveRecord::Migration[7.0]
  def change
    create_table :qrlinks do |t|
      t.references :label, null: false, foreign_key: true
      t.references :qrcode, null: false, foreign_key: true
      t.string :url, null: false
      t.timestamps
    end
  end
end
