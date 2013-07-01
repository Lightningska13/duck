class Rescat < ActiveRecord::Base
  has_and_belongs_to_many :resources, :order=>"position asc, resource_type ASC, title asc"
	validates_presence_of :category
	attr_accessible :category, :blurb, :restricted
	
	scope :visible, where(['restricted != ? OR restricted is null', true])
  scope :restricted, where(['restricted = ?', true])
  
  def self.get_restricted(user)
    if user && (user.admin_level >= 5)
       restricted
    elsif user && (user.admin_level == 5)
      user.rescats
    end
  end
end
