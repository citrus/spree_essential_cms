class Spree::Content < ActiveRecord::Base
  
  belongs_to :page
  validates_associated :page
  validates_presence_of :title, :page

  default_scope order(:position)
  
  if defined?(SpreeHeroku)
    has_attached_file :attachment,
      :styles => Proc.new{ |clip| clip.instance.attachment_sizes },
      :default_style => :preview,
      :path => "assets/contents/:id/:style/:basename.:extension",
      :storage => "s3",
      :s3_credentials => "#{Rails.root}/config/s3.yml"
  else
    has_attached_file :attachment,
      :styles => Proc.new{ |clip| clip.instance.attachment_sizes },
      :default_style => :preview,
      :url => "/assets/contents/:id/:style/:basename.:extension",
      :path => ":rails_root/public/assets/contents/:id/:style/:basename.:extension"
  end
  
  
  cattr_reader :per_page
  @@per_page = 10
  
  
  scope :for, Proc.new{|context| where(:context => context)}
  
    
  [ :link_text, :link, :body ].each do |property|
    define_method "has_#{property.to_s}?" do
      has_value property
    end
  end
  
  def has_full_link?
    has_link? && has_link_text?
  end
 	
  def has_image?
    has_value(:attachment_file_name) && attachment_file_name.match(/gif|jpg|png/i)
  end
  
  def hide_title?
    self.hide_title == true
  end
  
  
  def rendered_body
    RDiscount.new(body.to_s).to_html.html_safe
  end
    
  
  def default_attachment_sizes
    { :mini => '48x48>', :medium => '427x287>' }
  end
 	
  def attachment_sizes
    case self.context
      when 'slideshow'
        sizes = default_attachment_sizes.merge(:slide => '955x476#')
      else
        sizes = default_attachment_sizes
    end
    sizes
  end
  
  
  
  def context=(value)
    write_attribute :context, value.to_s.parameterize
  end

  private
  
    def has_value(selector)
      v = self.send selector
      v && !v.to_s.blank?
    end

end