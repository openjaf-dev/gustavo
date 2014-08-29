module Spree
  Order.class_eval do

  	has_many :pax_contacts, :dependent => :destroy
  	accepts_nested_attributes_for :pax_contacts


  	insert_checkout_step :pax, :before => :address
    remove_checkout_step :delivery

  end
end
