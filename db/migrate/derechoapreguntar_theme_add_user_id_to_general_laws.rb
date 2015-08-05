# -*- encoding : utf-8 -*-
class DerechoaPreguntarThemeAddUserIdToGeneralLaws < ActiveRecord::Migration

  def self.up
    change_table(:general_laws) do |t|
      t.references :user
    end
  end

  def self.down
    remove_column :general_laws, :user_id
  end

end
