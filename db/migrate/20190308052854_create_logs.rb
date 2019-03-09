class CreateLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :logs do |t|
      t.integer :total_time, null: false, default: 0
      t.integer :status, null: false 
      t.references :member, foreign_key: true

      t.timestamps
    end
  end
end
