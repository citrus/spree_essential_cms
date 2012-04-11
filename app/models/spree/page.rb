class Spree::Page < ActiveRecord::Base
  
  class << self
  
    def find_by_path(_path)
      return super('/') if _path == "_home_" && self.exists?(:path => "/")
      super _path.to_s.sub(/^\/*/, "/").gsub("--", "/")
    end

  end
  
  attr_accessible :title, :path, :nav_title, :meta_title, :meta_description, :meta_keywords, :accessible, :visible
  alias_attribute :name, :title
  
  validates_presence_of :title
  validates :path, :presence => true, :uniqueness => { :case_sensitive => false }
  
  default_scope order(:position)
  
  scope :active,  where(:accessible => true)
  scope :visible, active.where(:visible => true)
  
  has_many :contents, :order => :position, :dependent => :destroy
  has_many :images, :as => :viewable, :class_name => "Spree::PageImage", :order => :position, :dependent => :destroy
  
  before_validation :set_defaults
  after_create :create_default_content
    
  def to_param
    return "_home_" if path == "/"
    path.sub(/^\/*/, "")
  end
  
  def meta_title
    val = read_attribute(:meta_title)
    val.blank? ? title : val
  end
  
  def for_context(context)
    contents.where(:context => context)
  end
  
  def has_context?(context)
    contents.where(:context => context).count
  end
    
  def matches?(_path)
    (root? && _path == "/") || (!root? && _path.match(path))
  end
  
  def root?
    self.path == "/"
  end
  
  def path=(value)
    value = value.to_s.strip
    value.gsub!(/[\/\-\_]+$/, "") unless value == "/"
    write_attribute :path, value
  end
  
  private
  
    def set_defaults
      return if title.blank?
      #return errors.add(:path, "is reserved. Please use another") if path.to_s =~ /home/
      self.nav_title = title if nav_title.blank?
      self.path = nav_title.parameterize if path.blank?
      self.path = "/" + path.sub(/^\//, "")
    end
    
    def create_default_content
      self.contents.create(:title => title)
    end
  		
end
  