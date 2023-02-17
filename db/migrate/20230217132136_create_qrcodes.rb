class CreateQrcodes < ActiveRecord::Migration[7.0]
  def change
    create_table :qrcodes do |t|
      t.references :batch, null: false, foreign_key: true
      t.string :code
      t.string :url

      t.timestamps
    end
  end
end
