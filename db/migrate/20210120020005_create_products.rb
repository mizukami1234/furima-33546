class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string   :product_name, null: false
      t.text        :text        ,         null: false
      t.integer     :price       ,         null: false
      t.references  :user        ,         foreign_key: true
      t.integer     :category_id,          null: false
      t.integer     :product_condition_id, null: false
      t.integer     :shipping_charge_id,   null: false
      t.integer     :shipment_source_id,   null: false
      t.integer     :estimated_shipping_date_id,   null: false
      t.timestamps
    end
  end
end
