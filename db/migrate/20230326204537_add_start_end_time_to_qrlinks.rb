class AddStartEndTimeToQrlinks < ActiveRecord::Migration[7.0]
  def change
    # add_column :qrlinks, :start_time, :datetime, null: false
    # add_column :qrlinks, :end_time, :datetime

    # add_index :qrlinks, [:qrcode_id, :end_time], unique: true
  end
end
