module Spree
  class Context < ActiveRecord::Base


    def self.build_from_params(params)

      context_params = {}

      params.delete!(:controller)
      params.delete!(:action)
      params.delete!(:button)
      params.delete!(:authenticity_token)
      params.delete!(:utf8)
      params.delete!(:checkout)

      params.each do |k, v|
      	  context_params[k] = v
      end

      string = context_params.to_s

      Spree::Context.create(:context => string)

    end

  end
end
