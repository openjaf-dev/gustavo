class ChangeContextColumnType < ActiveRecord::Migration
  def change
    change_column :spree_contexts, :context, :text, :limit => nil
  end
end
