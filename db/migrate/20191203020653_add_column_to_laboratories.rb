class AddColumnToLaboratories < ActiveRecord::Migration[5.2]
  def change
    add_column :laboratories, :member_updated_at, :datetime, null: false, default: DateTime.current
  end
end
