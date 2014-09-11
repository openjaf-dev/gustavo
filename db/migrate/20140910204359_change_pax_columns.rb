class ChangePaxColumns < ActiveRecord::Migration
  def change
    remove_column :spree_pax_contacts, :phone
    add_column :spree_pax_contacts, :last_name, :string
  end
end
