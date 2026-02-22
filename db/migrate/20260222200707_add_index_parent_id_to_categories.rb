class AddIndexParentIdToCategories < ActiveRecord::Migration[8.1]
  def change
    add_index :categories, :parent_id
    add_index :categories, :name
  end
end