class CreateQrcodes < ActiveRecord::Migration[7.0]
  def change
    create_table :qrcodes do |t|
      t.integer :referencenumber  , null: false
      t.string  :baseurl          , null: false
      t.timestamps

      t.index [ :referencenumber ], unique: true
    end
  end
end