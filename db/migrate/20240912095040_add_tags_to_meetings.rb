class AddTagsToMeetings < ActiveRecord::Migration[7.1]
  def change
    add_column :meetings, :tags, :string, array: true, default: []
  end
end
