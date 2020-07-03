class AddSlackurlsToLaboratories < ActiveRecord::Migration[5.2]
  def change
    add_column :laboratories, :slack_url, :string, null: true
  end
end
