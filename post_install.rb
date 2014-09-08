# This file is executed in the Rails evironment by the `rails-post-deploy`
# script

def column_exists?(table, column)
  # TODO: ActiveRecord 3 includes "column_exists?" method on `connection`
  ActiveRecord::Base.connection.columns(table.to_sym).collect{|c| c.name.to_sym}.include?(column)
end

def table_exists?(table)
  ActiveRecord::Base.connection.table_exists?(table)
end

# Add the identity_card_number field to the User model
unless column_exists?(:users, :identity_card_number)
  migration_file_path = '../db/migrate/derechoapreguntar_theme_add_identity_card_number_to_user'
  require File.expand_path migration_file_path, __FILE__
  DerechoaPreguntarThemeAddIdentityCardNumberToUser.up
end

unless table_exists?(:general_laws)
  migration_file_path = '../db/migrate/derechoapreguntar_theme_create_general_laws'
  require File.expand_path migration_file_path, __FILE__
  DerechoaPreguntarThemeCreateGeneralLaws.up
end

unless column_exists?(:general_laws, :user_id)
  migration_file_path = '../db/migrate/derechoapreguntar_theme_add_user_id_to_general_laws'
  require File.expand_path migration_file_path, __FILE__
  DerechoaPreguntarThemeAddUserIdToGeneralLaws.up
end
