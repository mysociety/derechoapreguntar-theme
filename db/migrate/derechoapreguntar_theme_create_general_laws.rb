# -*- encoding : utf-8 -*-
class DerechoaPreguntarThemeCreateGeneralLaws < ActiveRecord::Migration
  def self.up
    create_table :general_laws do |t|
      t.column :date_of_birth, :date, :null => false
      t.column :marital_status, :string, :null => false
      t.column :occupation, :string, :null => false
      # domicile uses a text column to support full addresses
      t.column :domicile, :text, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :general_laws
  end
end
