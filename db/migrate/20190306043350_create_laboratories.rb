class CreateLaboratories < ActiveRecord::Migration[5.2]
  def change
    create_table :laboratories do |t|
      t.string  :loginname, null: false, default: ""
      t.string  :displayname, null: false, default: ""
      t.integer :place, null: false

      t.timestamps
    end
    add_index :laboratories, :loginname, unique: true
  end
end
