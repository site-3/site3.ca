class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.text :name, null: false
      t.text :email, null: false

      t.text :rfid
      t.text :stripe_id
      t.text :notes

      t.timestamps null: false
    end
  end
end
