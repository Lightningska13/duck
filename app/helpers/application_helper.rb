module ApplicationHelper
  def get_path(parent,page)
    "/#{parent}/#{page}"
  end
  def section_link(name,options)
			#if options[:action] == @current_action and options[:controller] == @current_controller
			#changed this to just the controller - may change it back
			if options[:controller] == @current_controller
				 link_to(name, options, :class => 'active')
			else
				link_to(name,options)
			end
	end
	def get_icon(mime)
		if mime == "application/msword"
			thisClass = "word"
		elsif  mime == "application/ms-excel" or mime == "application/vnd.ms-excel"
			thisClass = "excel"
		elsif  mime == "application/pdf"
			thisClass = "pdf"
		elsif  mime == "application/octet"
			thisClass = "pdf"
		else
			thisClass = "doc"
		end
		return thisClass
	end
  def facet_link(name,options)
			#if options[:action] == @current_action and options[:controller] == @current_controller
			#changed this to just the controller - may change it back
			if options[:controller] == @current_controller  and options[:action] == @current_action and options[:id].to_s == @cur_id.to_s
				 link_to(name, options, :class => 'active' )
			else
				link_to(name,options)
			end
	end
	def check_restricted(restricted)
	  if restricted 
	    raw('<span class="restricted">RESTRICTED</span>')
	  end
	end
end
