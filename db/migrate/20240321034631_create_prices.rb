class CreatePrices < ActiveRecord::Migration[7.1]
  def change
    create_table :prices do |t|
      t.references :stock, null: false, foreign_key: true
      t.decimal :price
      t.datetime :timestamp

      t.timestamps
    end
  end
end
