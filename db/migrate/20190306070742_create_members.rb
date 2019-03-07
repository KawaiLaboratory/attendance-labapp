class CreateMembers < ActiveRecord::Migration[5.2]
  def change
    create_table :members do |t|
      t.string :name, null: false, default: ""
      t.integer :grade, null: false, default: 0
      t.integer :status, null: false, default: 0
      t.datetime :changed_at, null: false
      t.references :laboratory, foreign_key: true

      t.timestamps
    end
  end
end
