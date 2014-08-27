# Uninstall hook code here

def column_exists?(table, column)
  # TODO: ActiveRecord 3 includes "column_exists?" method on `connection`
  ActiveRecord::Base.connection.columns(table.to_sym).collect{|c| c.name.to_sym}.include?(column)
end

# Remove the id_number field to the User model
if column_exists?(:users, :id_number)
  require File.expand_path '../db/migrate/derechoapreguntar_theme_add_id_number_to_user', __FILE__
  DerechoaPreguntarThemeAddIdNumberToUser.down
end
