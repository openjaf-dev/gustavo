module Spree
  Order.class_eval do

  	has_many :pax_contacts, :dependent => :destroy
    has_one :context, :dependent => :destroy

    accepts_nested_attributes_for :pax_contacts


  	insert_checkout_step :pax, :before => :payment
    insert_checkout_step :confirm, :before => :complete
    remove_checkout_step :delivery

  end
end
