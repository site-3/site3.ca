class MembersAddUniqueForRfid < ActiveRecord::Migration
  def change
    add_index :members, :rfid, unique: true
  end
end
