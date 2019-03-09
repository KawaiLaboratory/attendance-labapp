class CreateMembers < ActiveRecord::Migration[5.2]
  def change
    create_table :members do |t|
      t.string :firstname, null: false, default: ""
      t.string :lastname, null: false, default: ""
      t.integer :grade, null: false
      t.integer :status, null: false
      t.datetime :changed_at, null: false
      t.boolean :go_cafeteria, null: false, default: "true"
      t.references :laboratory, foreign_key: true

      t.timestamps
    end
  end
end
