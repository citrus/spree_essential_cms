class PageImage < Image

  validate :no_attachement_errors

  if defined?(SpreeHeroku)
    has_attached_file :attachment,
      :styles => Proc.new{ |clip| clip.instance.attachment_sizes },
      :default_style => :medium,
      :path => "assets/posts/:id/:style/:basename.:extension",
      :storage => "s3",
      :s3_credentials => "#{Rails.root}/config/s3.yml"
  else
    has_attached_file :attachment,
      :styles => Proc.new{ |clip| clip.instance.attachment_sizes },
      :default_style => :medium,
      :url => "/assets/posts/:id/:style/:basename.:extension",
      :path => ":rails_root/public/assets/posts/:id/:style/:basename.:extension"
  end 
 
  def image_content?
    attachment_content_type.match(/\/(jpeg|png|gif|tiff|x-photoshop)/)
  end
     
  def attachment_sizes
    sizes = {}
    sizes.merge!(:mini => '48x48>', :small => '150x150>', :medium => '420x300>', :large => '900x650>') if image_content?
    sizes.merge!(:slide => '950x250#') if viewable.respond_to?(:path) && viewable.path == "/"
    sizes
  end
  
  def no_attachement_errors
    unless attachment.errors.empty?
      # uncomment this to get rid of the less-than-useful interrim messages
      errors.clear
      errors.add :attachment, "Paperclip returned errors for file '#{attachment_file_name}' - check ImageMagick installation or image source file."
      false
    end
  end
  
end
