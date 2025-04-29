class CreateCommutes < ActiveRecord::Migration[7.1]
  def change
    create_table :commutes do |t|
      t.references :user, null: false, foreign_key: true
      t.string :transport_mode, null: false
      t.string :from_location, null: false
      t.string :to_location, null: false
      t.timestamps
    end
  end
end
