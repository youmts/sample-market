class CreateIdentities2 < ActiveRecord::Migration[5.2]
  def change
    create_table :identities do |t|
      t.string :uid, null: false
      t.string :provider, null: false
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
