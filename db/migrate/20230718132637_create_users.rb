class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string   :username
      t.string   :eth_address
      t.string   :nonce_digest
      t.datetime :nonce_at
      t.string   :remember_digest
      t.timestamps
    end
  end
end
