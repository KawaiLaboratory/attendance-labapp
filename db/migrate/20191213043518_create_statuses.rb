class CreateStatuses < ActiveRecord::Migration[5.2]
  def change
    create_table :statuses do |t|
      t.integer :color, null: false, default: 0
      t.string :name, null: false 
      t.boolean :active, null: false, default: false
      t.references :laboratory, foreign_key: true

      t.timestamps
    end
  end
end
