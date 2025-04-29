class AddCommuteToAssociationToLocation < ActiveRecord::Migration[7.1]
  def change
    add_reference :locations, :commute, null: false, foreign_key: true
  end
end
