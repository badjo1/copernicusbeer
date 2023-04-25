class AddValidUntilToQrlinks < ActiveRecord::Migration[7.0]
  def change
    add_column :qrlinks, :valid_until, :datetime
  end
end
