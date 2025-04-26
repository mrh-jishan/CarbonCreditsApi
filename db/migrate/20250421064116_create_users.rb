class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :org_slug
      t.string :clerk_user_id
      t.string :org_role

      t.timestamps
    end
    add_index :users, :email, unique: true
  end
end
