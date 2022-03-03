class CreateBulkDiscounts < ActiveRecord::Migration[5.2]
  def change
    create_table :bulk_discounts do |t|
      t.references :merchants, foreign_key: true
      t.integer :percentage
      t.integer :quantity_threshold

      t.timestamps
    end
  end
end