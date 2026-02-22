class CreateProducts < ActiveRecord::Migration[8.1]
  def change
    create_table :products do |t|
      t.string :name, index: true
      t.text :description
      t.decimal :price, index: true
      t.integer :stock

      t.timestamps
    end
  end
end
