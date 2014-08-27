class DerechoaPreguntarThemeAddIdNumberToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :id_number, :string
  end

  def self.down
    remove_column :users, :id_number, :string
  end
end
