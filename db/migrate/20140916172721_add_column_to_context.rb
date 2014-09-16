class AddColumnToContext < ActiveRecord::Migration
  def change
    add_column :spree_contexts, :order_id, :integer
  end
end
