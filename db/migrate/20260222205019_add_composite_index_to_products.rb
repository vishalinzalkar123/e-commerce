class AddCompositeIndexToProducts < ActiveRecord::Migration[8.1]
  def change
    add_index :products, [:category_id, :price]
  end
end
