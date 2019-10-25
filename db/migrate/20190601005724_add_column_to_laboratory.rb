class AddColumnToLaboratory < ActiveRecord::Migration[5.2]
  def change
    add_column :laboratories, :last_updated_at, :datetime, null: false, default: DateTime.current
  end
end
