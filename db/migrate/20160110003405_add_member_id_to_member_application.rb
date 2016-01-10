class AddMemberIdToMemberApplication < ActiveRecord::Migration
  def change
    change_table(:member_applications) do |t|
      t.integer :member_id, null: true
    end
    add_index :member_applications, [:member_id], unique: true
  end
end
