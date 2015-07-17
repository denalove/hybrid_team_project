class Member < ActiveRecord::Base
	belongs_to :company
	# has_attached_file :photo, styles: { medium: "300x300>", small: "150x150>", thumb: "100x100>" }
	
	# validates_attachment_content_type :photo, content_type: /\Aimage\/.*\Z/

	has_attached_file :photo,
  	:storage => :s3,
  	:s3_credentials => Proc.new{|a| a.instance.s3_credentials },
  	# :path => ":rails_root/public/system/:attachment/:id/:basename_:style.:extension",
  	:path => '/:class/:id/:style/:filename',
  	# :url => "/system/:attachment/:id/:basename_:style.:extension",
  	:url =>':s3_domain_url',


  	:styles => {
   	 	:admin    => ['100x100#',  :jpg, :quality => 70],
    	:thumb    => ['250x250#',  :jpg, :quality => 70],
    	:preview  => ['500x500#',  :jpg, :quality => 70],
   	 	:retina   => ['1200>',     :jpg, :quality => 30]
  	},

  	:convert_options => {
    	:admin    => '-set colorspace sRGB -strip',
    	:thumb    => '-set colorspace sRGB -strip',
    	:preview  => '-set colorspace sRGB -strip',
    	:retina   => '-set colorspace sRGB -strip -sharpen 0x0.5'
  	}

  validates_attachment_content_type :photo, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]



  def s3_credentials
    {:bucket => ENV['AWS_BUCKET'], :access_key_id => ENV["access_key_id"], :secret_access_key => ENV["secret_access_key"]}
  end
end

