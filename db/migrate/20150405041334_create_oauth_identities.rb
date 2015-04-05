class CreateOauthIdentities < ActiveRecord::Migration
  def change
    create_table :oauth_identities do |t|
      t.references :member, null: false

      t.string :provider, null: false
      t.string :uid, null: false
    end

    add_index :oauth_identities, [:provider, :uid], unique: true
    add_index :oauth_identities, [:member_id, :provider], unique: true
  end
end
