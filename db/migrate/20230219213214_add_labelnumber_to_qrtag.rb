class AddLabelnumberToQrtag < ActiveRecord::Migration[7.0]
  def change
    add_column :qrtags, :labelnumber, :integer, null: false
  end
end
