class Faq < ActiveRecord::Base
#	has_and_belongs_to_many :categories
	validates_presence_of :answer, :question => { :maximum => 10}
	attr_accessible :question, :answer, :position, :featured
# be sure to install acts_as_list plugin
# $ rails plugin install https://github.com/rails/acts_as_list.git
  acts_as_list
	
 	def self.search(search)
 		if search
 			search = search.to_s.downcase
  			where(['lower(question) LIKE ? OR lower(answer) LIKE ?', "%#{search}%", "%#{search}%"]).order('position ASC')
    end
 	end

	def self.find_for_home
		where('featured=?',true).order("position asc").limit(1)
	end
end
