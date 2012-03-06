class AddSpreeNamespace < ActiveRecord::Migration
  def up
    rename_table :contents, :spree_contents
    rename_table :pages, :spree_pages
  end

  def down
    rename_table :spree_contents, :contents
    rename_table :spree_pages, :pages
  end
end
