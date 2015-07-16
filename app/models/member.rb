class Member < ActiveRecord::Base
	belongs_to :company
	# has_attached_file :photo, :styles => { :small '150x150>', :thumb => '100x100>' }
	# validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/

end
