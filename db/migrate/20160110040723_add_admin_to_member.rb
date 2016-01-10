class AddAdminToMember < ActiveRecord::Migration
  def change
    change_table(:members) do |t|
      t.boolean :admin, null: false, default: false
    end
  end
end
