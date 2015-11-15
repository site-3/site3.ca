class AddRfidToMemberApplications < ActiveRecord::Migration
  def change
    add_column :member_applications, :rfid, :text, null: true
  end
end
