class DashController < ApplicationController
	def index
    @page_title = "Duck Lake Country Club"
    @user_session=UserSession.new
    @events = Event.order("start_date asc").limit(3)
	end
end
