class Page < ActiveRecord::Base
  has_attached_file :pagepic, :styles => { :tiny => "25x25#", :small => "72x72#", :medium => "150", :large => "845x200"} 
  validates_presence_of :title
  
  acts_as_list
  
  attr_accessible :description, :pagepic, :pagepic_file_name, :parent, :published, :title
  
  scope :about, where(:parent => 'about')
  scope :membership, where(:parent => 'membership')
  scope :wedding, where(:parent => 'wedding')
end
