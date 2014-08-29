module Spree
  LineItem.class_eval do

    has_many :line_details

  end
end
