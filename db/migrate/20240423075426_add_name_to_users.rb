# db/migrate/XXXXXXXXXXXXXX_add_name_to_users.rb
class AddNameToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :name, :string
  end
end
