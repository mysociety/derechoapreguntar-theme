# -*- encoding : utf-8 -*-
# This file is executed in the Rails evironment by the `rails-post-deploy`
# script

def table_exists?(table)
  ActiveRecord::Base.connection.table_exists?(table)
end

def column_exists?(table, column)
  if table_exists?(table)
    ActiveRecord::Base.connection.column_exists?(table, column)
  end
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

# Create any necessary global Censor rules
require File.expand_path(File.dirname(__FILE__) + '/lib/censor_rules')
