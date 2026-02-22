class CreateProductImages < ActiveRecord::Migration[8.1]
  def change
    create_table :product_images do |t|
      t.string :image_url
      t.references :imageable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
