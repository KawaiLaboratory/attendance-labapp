class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.references :laboratory, foreign_key: true
      t.references :member, foreign_key: true
      t.datetime :started_at, null: false
      t.datetime :fineshed_at, null: false
      t.string :title, null: false
      t.string :comment
      t.integer :status, null: false, default: 0
      t.boolean :all_day, null: false, default: false

      t.timestamps
    end
  end
end
