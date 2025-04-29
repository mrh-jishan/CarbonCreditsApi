class RemoveTimeStampFromLocation < ActiveRecord::Migration[7.1]
  def change
    remove_column :locations, :timestamp, :datetime    
  end
end
