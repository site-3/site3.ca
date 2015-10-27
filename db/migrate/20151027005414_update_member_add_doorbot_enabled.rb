class UpdateMemberAddDoorbotEnabled < ActiveRecord::Migration
  def change
    add_column :members, :doorbot_enabled, :boolean, null: false, default: false
  end
end
