class AddEnableVendingMachineToUser < ActiveRecord::Migration
  def change
    add_column :members, :enable_vending_machine, :boolean, null: false, default: false
  end
end
