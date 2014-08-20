class CreateSpreeContexts < ActiveRecord::Migration
  def up
    create_table :spree_contexts do |t|
      t.string :context

      t.timestamps
    end
  end

  def down
    drop_table :spree_contexts
  end
end
