class AddArchivedToMembers < ActiveRecord::Migration[5.2]
  def change
    add_column :members, :archived, :boolean, default: false, null: false
  end
end
