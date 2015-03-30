class CreateMemberApplications < ActiveRecord::Migration
  def change
    create_table :member_applications do |t|
      t.text :name, null: false
      t.text :email, null: false

      t.timestamps null: false
    end
  end
end
