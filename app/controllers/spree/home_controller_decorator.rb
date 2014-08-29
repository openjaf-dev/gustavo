module Spree
   HomeController.class_eval do

    def index
      # @searcher = build_searcher(params)
      # @products = @searcher.retrieve_products
      @taxonomies = Spree::Taxonomy.includes(root: :children)
    end

  end
end
