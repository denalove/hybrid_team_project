class AddPhotoColumnsToMembers < ActiveRecord::Migration
  def up
  	add_attachment :members, :photo
  end

  def down
  	remove_attachment :members, :photo
  end

end
