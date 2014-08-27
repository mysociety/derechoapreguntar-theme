# Here you can override or add to the pages in the core website
Rails.application.routes.draw do
  match '/profile/id_number/edit' => 'user_id_number#edit', :as => :user_edit_id_number, :via => :get
  match '/profile/id_number' => 'user_id_number#update', :as => :user_update_id_number, :via => :put
end
