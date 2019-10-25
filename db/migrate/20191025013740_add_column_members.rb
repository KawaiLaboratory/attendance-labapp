class AddColumnMembers < ActiveRecord::Migration[5.2]
  def change
    add_column :members, :class_number, :integer, null: false, default: 0, comment: "気に入らないけど応急処置"
  end
end
