class AddPictureToActivities < ActiveRecord::Migration[5.1]
  def change
    add_column :activities, :picture, :string
  end
end
