class CreatePaxContacts < ActiveRecord::Migration
  def self.up
    create_table :spree_pax_contacts do |t|
      t.string :first_name
      t.string :phone
      t.text :special_request
      t.references :order
      t.timestamps
    end
  end

  def self.down
    drop_table :spree_pax_contacts
  end


end
