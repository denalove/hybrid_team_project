class Member < ActiveRecord::Base
	validates_presence_of :name, :email, :photo
  belongs_to :company
  validates :email, uniqueness: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
  validates_length_of :name, minimum: 3


  has_attached_file :photo,
    :storage => :s3,
    :s3_credentials => Proc.new{|a| a.instance.s3_credentials },
  	# :path => ":rails_root/public/system/:attachment/:id/:basename_:style.:extension",
  	:path => '/:class/:id/:style/:filename',
  	# :url => "/system/:attachment/:id/:basename_:style.:extension",
  	:url =>':s3_domain_url',

  	:styles => {
      :small    => ['150x150#',  :jpg, :quality => 70],
      :medium    => ['300x300#',  :jpg, :quality => 70],
      :thumb    => ['100x100#',  :jpg, :quality => 70],
      :preview  => ['500x500#',  :jpg, :quality => 70],
      },

    :convert_options => {
       :small    => '-set colorspace sRGB -strip',
       :medium    => '-set colorspace sRGB -strip',
       :thumb    => '-set colorspace sRGB -strip',
       :preview  => '-set colorspace sRGB -strip',
     }

  validates_attachment_content_type :photo, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]


  def s3_credentials
    {:bucket => ENV['AWS_BUCKET'], :access_key_id => ENV["access_key_id"], :secret_access_key => ENV["secret_access_key"]}
  end
end

