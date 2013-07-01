class Resource < ActiveRecord::Base
  has_attached_file :res 
 	has_and_belongs_to_many :rescats
 	#has_and_belongs_to_many :facets, :order=>"position asc"

   validates_presence_of :res_file_name, :message => "( Document/URL ) cannot be empty"
   validates_presence_of :title
   attr_accessible :resource_type, :title, :description, :res, :rescat_ids, :res_file_name, :res_content_type, :res_file_size, :featured, :position
 	 scope :visible, includes(:rescats).where(['rescats.restricted != ? OR rescats.restricted is null', true])
 	acts_as_list

  # this before filter and associated function is supposed to allow the upload of a non-image file
 	before_post_process :image?

 	def image?
 		!(res_content_type =~ /^image.*/).nil?
 	end

 	def self.search(search)
 		if search
 			search = search.to_s.downcase
 			where(['lower(title) LIKE ? OR lower(description) LIKE ?', "%#{search}%", "%#{search}%"]).order('position asc')
 		#else
 		#	find(:all)
 	  end
 	end

 	def self.find_for_home(normal)
 	  unless normal
 		 where('featured=?',true).order(:position).visible
 		else
  	 where('featured=?',true).order(:position)
 		end
 	end
end
