class AddIndexToProductStocks < ActiveRecord::Migration[8.1]
  def change
    add_index :products, :stock
  end
end
