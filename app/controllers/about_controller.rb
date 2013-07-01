class AboutController < ApplicationController
  def index
    @page_title="About"
    @nav=Page.about.order(:position)
    @page=@nav.first

    render ('/pages/show')
  end
  
  def show
    @page_title="About"
    @nav=Page.about.order(:position)
    if params[:id]
      @page=Page.find(params[:id])
    else
      @page=@nav.first
    end
    render ('/pages/show')
  end
end
